import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/sensor_reading.dart';

class SensorProvider extends ChangeNotifier {
  AccelerometerData _currentAccelerometer = AccelerometerData.zero();
  GyroscopeData _currentGyroscope = GyroscopeData.zero();
  SpiritLevelData _spiritLevel = SpiritLevelData(pitch: 0.0, roll: 0.0);
  SoundLevelData _soundLevel = SoundLevelData(decibels: 42.0, peakDecibels: 68.0, timestamp: DateTime.now());

  double _compassHeading = 0.0;
  bool _isSensorActive = false;
  bool _useSimulation = false;

  // Zero Calibration Offsets for Level
  double _pitchOffset = 0.0;
  double _rollOffset = 0.0;

  // Circular history list for real-time fl_chart line chart (last 30 points)
  final List<AccelerometerData> _accelerometerHistory = [];

  StreamSubscription<UserAccelerometerEvent>? _accelSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  StreamSubscription<MagnetometerEvent>? _magSub;
  Timer? _simulationTimer;
  Timer? _soundTimer;

  AccelerometerData get currentAccelerometer => _currentAccelerometer;
  GyroscopeData get currentGyroscope => _currentGyroscope;
  SpiritLevelData get spiritLevel => _spiritLevel;
  SoundLevelData get soundLevel => _soundLevel;
  double get compassHeading => _compassHeading;
  bool get isSensorActive => _isSensorActive;
  bool get useSimulation => _useSimulation;
  List<AccelerometerData> get accelerometerHistory => List.unmodifiable(_accelerometerHistory);

  SensorProvider() {
    initSensors();
  }

  @override
  void dispose() {
    _stopSensors();
    super.dispose();
  }

  void initSensors() {
    _isSensorActive = true;
    notifyListeners();

    if (_useSimulation || kIsWeb || !defaultTargetPlatformMatchesMobile()) {
      _startSimulation();
      _startSoundSimulation();
      return;
    }

    try {
      // Hardware sensors initialization
      _accelSub = userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
        _onAccelerometerEvent(event.x, event.y, event.z);
      }, onError: (_) => _startSimulation());

      _gyroSub = gyroscopeEventStream().listen((GyroscopeEvent event) {
        _currentGyroscope = GyroscopeData(x: event.x, y: event.y, z: event.z, timestamp: DateTime.now());
        notifyListeners();
      });

      _magSub = magnetometerEventStream().listen((MagnetometerEvent event) {
        final heading = (atan2(event.y, event.x) * (180 / pi)) % 360;
        _compassHeading = heading < 0 ? heading + 360 : heading;
        notifyListeners();
      });

      _startSoundSimulation();
    } catch (_) {
      _startSimulation();
      _startSoundSimulation();
    }
  }

  bool defaultTargetPlatformMatchesMobile() {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  void toggleSimulationMode(bool enable) {
    _useSimulation = enable;
    _stopSensors();
    initSensors();
  }

  void calibrateLevelZero() {
    _pitchOffset = _spiritLevel.pitch + _pitchOffset;
    _rollOffset = _spiritLevel.roll + _rollOffset;
    notifyListeners();
  }

  void resetLevelCalibration() {
    _pitchOffset = 0.0;
    _rollOffset = 0.0;
    notifyListeners();
  }

  void _onAccelerometerEvent(double x, double y, double z) {
    final now = DateTime.now();
    final data = AccelerometerData(x: x, y: y, z: z, timestamp: now);
    _currentAccelerometer = data;

    _accelerometerHistory.add(data);
    if (_accelerometerHistory.length > 30) {
      _accelerometerHistory.removeAt(0);
    }

    // Calculate Pitch and Roll (in degrees)
    double rawPitch = (atan2(y, sqrt(x * x + z * z)) * (180 / pi));
    double rawRoll = (atan2(-x, z) * (180 / pi));

    double pitch = rawPitch - _pitchOffset;
    double roll = rawRoll - _rollOffset;
    bool isLevel = (pitch.abs() < 0.8) && (roll.abs() < 0.8);

    _spiritLevel = SpiritLevelData(
      pitch: pitch,
      roll: roll,
      isCalibrated: (_pitchOffset != 0 || _rollOffset != 0),
      isLevel: isLevel,
    );

    notifyListeners();
  }

  void _startSimulation() {
    _simulationTimer?.cancel();
    double tickCount = 0;

    _simulationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      tickCount += 0.1;

      double simX = sin(tickCount) * 4.5 + (randomNoise() * 0.5);
      double simY = cos(tickCount * 0.8) * 3.2 + (randomNoise() * 0.4);
      double simZ = 9.81 + sin(tickCount * 0.5) * 1.2;

      _onAccelerometerEvent(simX, simY, simZ);

      _currentGyroscope = GyroscopeData(
        x: sin(tickCount * 1.2) * 0.8,
        y: cos(tickCount * 1.5) * 0.6,
        z: sin(tickCount * 0.7) * 0.4,
        timestamp: DateTime.now(),
      );

      _compassHeading = (120 + sin(tickCount * 0.3) * 40) % 360;
      notifyListeners();
    });
  }

  void _startSoundSimulation() {
    _soundTimer?.cancel();
    double maxPeak = 65.0;

    _soundTimer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      double currentDb = 35.0 + (Random().nextDouble() * 35.0);
      if (currentDb > maxPeak) maxPeak = currentDb;

      _soundLevel = SoundLevelData(
        decibels: currentDb,
        peakDecibels: maxPeak,
        timestamp: DateTime.now(),
      );
      notifyListeners();
    });
  }

  double randomNoise() => (Random().nextDouble() - 0.5);

  void _stopSensors() {
    _accelSub?.cancel();
    _gyroSub?.cancel();
    _magSub?.cancel();
    _simulationTimer?.cancel();
    _soundTimer?.cancel();
    _isSensorActive = false;
  }
}
