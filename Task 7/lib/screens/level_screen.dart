import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/spirit_level_widget.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sensorProv = Provider.of<SensorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Spirit Level"),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => sensorProv.calibrateLevelZero(),
            tooltip: "Zero Calibrate Surface",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          children: [
            GlassCard(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: SpiritLevelWidget(
                levelData: sensorProv.spiritLevel,
                onCalibrate: () {
                  sensorProv.calibrateLevelZero();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Surface calibrated to 0.0° zero reference.")),
                  );
                },
                onReset: () => sensorProv.resetLevelCalibration(),
              ),
            ),
            const SizedBox(height: 16),

            // Inclinometer Usage & Telemetry Specs
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF00E5FF), size: 20),
                      SizedBox(width: 8),
                      Text("Inclinometer Telemetry & Calibration", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Place your mobile device flat on any surface (tables, frames, shelves) to measure surface tilt accuracy. When the target turns green and locks, your surface is perfectly level.",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecItem("Tolerance", "± 0.5°"),
                      _buildSpecItem("Sampling", "60 Hz"),
                      _buildSpecItem("Status", sensorProv.spiritLevel.isCalibrated ? "Calibrated" : "Default"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
