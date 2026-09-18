import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/location_data.dart';

class LocationProvider extends ChangeNotifier {
  TelemetryLocationData _currentLocation = TelemetryLocationData.defaultLocation();
  bool _isLoading = false;
  bool _isLiveTracking = false;
  bool _useSimulation = false;
  String? _errorMessage;

  List<LocationBookmark> _bookmarks = [];
  StreamSubscription<Position>? _positionSubscription;
  Timer? _simulationTimer;

  TelemetryLocationData get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  bool get isLiveTracking => _isLiveTracking;
  bool get useSimulation => _useSimulation;
  String? get errorMessage => _errorMessage;
  List<LocationBookmark> get bookmarks => List.unmodifiable(_bookmarks);

  LocationProvider() {
    _loadBookmarks();
    initLocationService();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _simulationTimer?.cancel();
    super.dispose();
  }

  Future<void> initLocationService() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_useSimulation || kIsWeb || !defaultTargetPlatformMatchesMobile()) {
      _startSimulation();
      return;
    }

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage = "Location services are disabled on this device.";
        _startSimulation();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = "Location permissions are denied.";
          _startSimulation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _errorMessage = "Location permissions are permanently denied.";
        _startSimulation();
        return;
      }

      // Fetch current position natively
      Position pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      await _updateFromPosition(pos, isSimulated: false);
      _isLoading = false;
      notifyListeners();

      // Start live stream
      startLiveTracking();
    } catch (e) {
      _errorMessage = "Failed to access native GPS: $e";
      _startSimulation();
    }
  }

  bool defaultTargetPlatformMatchesMobile() {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  void toggleSimulationMode(bool enable) {
    _useSimulation = enable;
    if (_useSimulation) {
      _positionSubscription?.cancel();
      _startSimulation();
    } else {
      _simulationTimer?.cancel();
      initLocationService();
    }
    notifyListeners();
  }

  void toggleLiveTracking() {
    if (_isLiveTracking) {
      stopLiveTracking();
    } else {
      startLiveTracking();
    }
  }

  void startLiveTracking() {
    _isLiveTracking = true;
    notifyListeners();

    if (_useSimulation || !defaultTargetPlatformMatchesMobile()) {
      _startSimulationTimer();
    } else {
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      );
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (Position position) {
          _updateFromPosition(position, isSimulated: false);
        },
        onError: (err) {
          _errorMessage = "GPS Stream error: $err";
          notifyListeners();
        },
      );
    }
  }

  void stopLiveTracking() {
    _isLiveTracking = false;
    _positionSubscription?.cancel();
    _simulationTimer?.cancel();
    notifyListeners();
  }

  void _startSimulationTimer() {
    _simulationTimer?.cancel();
    double lat = _currentLocation.latitude;
    double lng = _currentLocation.longitude;
    double heading = 45.0;

    _simulationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_isLiveTracking && !_useSimulation) return;
      lat += (0.00015 * (1 - (timer.tick % 3)));
      lng += (0.00018 * (1 - (timer.tick % 2)));
      heading = (heading + 5) % 360;

      _currentLocation = TelemetryLocationData(
        latitude: lat,
        longitude: lng,
        altitude: 18.5 + (timer.tick % 4),
        speed: 12.4 + (timer.tick % 3),
        heading: heading,
        accuracy: 4.2,
        formattedAddress: "Live Simulated Coordinates (Telemetry active)",
        city: "Tech Valley",
        country: "USA",
        timestamp: DateTime.now(),
        isSimulated: true,
      );
      _isLoading = false;
      notifyListeners();
    });
  }

  void _startSimulation() {
    _isLoading = false;
    _currentLocation = TelemetryLocationData.defaultLocation();
    notifyListeners();
  }

  Future<void> _updateFromPosition(Position pos, {required bool isSimulated}) async {
    String addressStr = "GPS Fix: ${pos.latitude.toStringAsFixed(5)}, ${pos.longitude.toStringAsFixed(5)}";
    String cityStr = "Live Telemetry";
    String countryStr = "GPS Position";

    _currentLocation = TelemetryLocationData(
      latitude: pos.latitude,
      longitude: pos.longitude,
      altitude: pos.altitude,
      speed: pos.speed,
      heading: pos.heading,
      accuracy: pos.accuracy,
      formattedAddress: addressStr,
      city: cityStr,
      country: countryStr,
      timestamp: DateTime.now(),
      isSimulated: isSimulated,
    );
    notifyListeners();
  }

  // Bookmarking methods
  Future<void> addBookmark(String title, String category) async {
    final newBookmark = LocationBookmark(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.isEmpty ? "Saved Location" : title,
      address: _currentLocation.formattedAddress,
      latitude: _currentLocation.latitude,
      longitude: _currentLocation.longitude,
      altitude: _currentLocation.altitude,
      timestamp: DateTime.now(),
      category: category,
    );
    _bookmarks.add(newBookmark);
    notifyListeners();
    await _saveBookmarks();
  }

  Future<void> removeBookmark(String id) async {
    _bookmarks.removeWhere((b) => b.id == id);
    notifyListeners();
    await _saveBookmarks();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _bookmarks.map((b) => b.toJson()).toList();
    await prefs.setString('location_bookmarks', jsonEncode(jsonList));
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('location_bookmarks');
    if (jsonStr != null) {
      try {
        final List<dynamic> list = jsonDecode(jsonStr);
        _bookmarks = list.map((item) => LocationBookmark.fromJson(item)).toList();
        notifyListeners();
      } catch (_) {}
    }
  }

  double calculateDistanceTo(double targetLat, double targetLng) {
    const Distance distance = Distance();
    return distance.as(
      LengthUnit.Kilometer,
      LatLng(_currentLocation.latitude, _currentLocation.longitude),
      LatLng(targetLat, targetLng),
    );
  }
}
