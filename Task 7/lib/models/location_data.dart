class LocationBookmark {
  final String id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final double altitude;
  final DateTime timestamp;
  final String category;

  LocationBookmark({
    required this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.timestamp,
    this.category = 'General',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'timestamp': timestamp.toIso8601String(),
        'category': category,
      };

  factory LocationBookmark.fromJson(Map<String, dynamic> json) =>
      LocationBookmark(
        id: json['id'] ?? '',
        title: json['title'] ?? 'Pinned Location',
        address: json['address'] ?? '',
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        altitude: (json['altitude'] as num).toDouble(),
        timestamp: DateTime.parse(json['timestamp']),
        category: json['category'] ?? 'General',
      );
}

class TelemetryLocationData {
  final double latitude;
  final double longitude;
  final double altitude;
  final double speed; // in m/s or km/h
  final double heading;
  final double accuracy;
  final String formattedAddress;
  final String city;
  final String country;
  final DateTime timestamp;
  final bool isSimulated;

  TelemetryLocationData({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
    required this.heading,
    required this.accuracy,
    required this.formattedAddress,
    required this.city,
    required this.country,
    required this.timestamp,
    this.isSimulated = false,
  });

  factory TelemetryLocationData.defaultLocation() {
    return TelemetryLocationData(
      latitude: 37.7749,
      longitude: -122.4194,
      altitude: 15.0,
      speed: 0.0,
      heading: 0.0,
      accuracy: 5.0,
      formattedAddress: "Market St, San Francisco, CA, USA",
      city: "San Francisco",
      country: "United States",
      timestamp: DateTime.now(),
      isSimulated: true,
    );
  }
}
