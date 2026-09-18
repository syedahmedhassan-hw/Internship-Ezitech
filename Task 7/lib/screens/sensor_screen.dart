import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';
import '../widgets/compass_widget.dart';
import '../widgets/glass_card.dart';
import '../widgets/sensor_chart.dart';
import '../widgets/sound_meter_widget.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sensorProv = Provider.of<SensorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Motion & Sensor Studio"),
        actions: [
          Row(
            children: [
              const Text("Simulate", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Switch(
                value: sensorProv.useSimulation,
                onChanged: (val) => sensorProv.toggleSimulationMode(val),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          children: [
            // 3-Axis Accelerometer Real-Time Telemetry Graph Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.query_stats, color: Color(0xFF00E5FF), size: 20),
                          SizedBox(width: 8),
                          Text("3-Axis Accelerometer Stream", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "G-Force: ${(sensorProv.currentAccelerometer.totalMagnitude / 9.81).toStringAsFixed(2)} g",
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SensorChartWidget(data: sensorProv.accelerometerHistory),
                  const SizedBox(height: 12),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildAxisBadge("X: ${sensorProv.currentAccelerometer.x.toStringAsFixed(2)} m/s²", const Color(0xFFFF5252)),
                        _buildAxisBadge("Y: ${sensorProv.currentAccelerometer.y.toStringAsFixed(2)} m/s²", const Color(0xFF69F0AE)),
                        _buildAxisBadge("Z: ${sensorProv.currentAccelerometer.z.toStringAsFixed(2)} m/s²", const Color(0xFF448AFF)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Compass & Gyroscope Grid Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 360 Digital Compass Card
                Expanded(
                  child: GlassCard(
                    child: Column(
                      children: [
                        const Text(
                          "DIGITAL COMPASS",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        CompassWidget(heading: sensorProv.compassHeading),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Gyroscope Card
                Expanded(
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "GYROSCOPE ROTATION",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        _buildGyroRow("Roll (X)", sensorProv.currentGyroscope.x),
                        const SizedBox(height: 6),
                        _buildGyroRow("Pitch (Y)", sensorProv.currentGyroscope.y),
                        const SizedBox(height: 6),
                        _buildGyroRow("Yaw (Z)", sensorProv.currentGyroscope.z),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status", style: TextStyle(fontSize: 9, color: Colors.grey)),
                              SizedBox(height: 2),
                              Text("100Hz Active", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Sound Decibel Telemetry
            GlassCard(
              child: SoundMeterWidget(soundData: sensorProv.soundLevel),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAxisBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace'),
      ),
    );
  }

  Widget _buildGyroRow(String axis, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(axis, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 1),
        Text(
          "${val.toStringAsFixed(2)} rad/s",
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
        ),
      ],
    );
  }
}
