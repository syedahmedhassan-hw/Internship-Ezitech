class AccelerometerData {
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;

  AccelerometerData({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  double get totalMagnitude => (x * x + y * y + z * z);

  factory AccelerometerData.zero() => AccelerometerData(
        x: 0.0,
        y: 0.0,
        z: 9.81,
        timestamp: DateTime.now(),
      );
}

class GyroscopeData {
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;

  GyroscopeData({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  factory GyroscopeData.zero() => GyroscopeData(
        x: 0.0,
        y: 0.0,
        z: 0.0,
        timestamp: DateTime.now(),
      );
}

class SpiritLevelData {
  final double pitch; // Angle around X-axis in degrees (-90 to +90)
  final double roll;  // Angle around Y-axis in degrees (-180 to +180)
  final bool isCalibrated;
  final bool isLevel; // True if within tolerance (e.g. < 0.5 degrees)

  SpiritLevelData({
    required this.pitch,
    required this.roll,
    this.isCalibrated = false,
    this.isLevel = false,
  });
}

class SoundLevelData {
  final double decibels;
  final double peakDecibels;
  final DateTime timestamp;

  SoundLevelData({
    required this.decibels,
    required this.peakDecibels,
    required this.timestamp,
  });
}
