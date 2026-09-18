import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';

class SoundMeterWidget extends StatelessWidget {
  final SoundLevelData soundData;

  const SoundMeterWidget({super.key, required this.soundData});

  @override
  Widget build(BuildContext context) {
    final ratio = (soundData.decibels / 120.0).clamp(0.0, 1.0);
    Color dbColor = const Color(0xFF00E676);
    if (soundData.decibels > 60) dbColor = const Color(0xFFFFAB00);
    if (soundData.decibels > 85) dbColor = const Color(0xFFFF5252);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NOISE TELEMETRY",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      soundData.decibels.toStringAsFixed(1),
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: dbColor),
                    ),
                    const SizedBox(width: 4),
                    const Text("dB SPL", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: dbColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: dbColor, width: 1),
              ),
              child: Text(
                "Peak: ${soundData.peakDecibels.toStringAsFixed(1)} dB",
                style: TextStyle(color: dbColor, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 12,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation<Color>(dbColor),
          ),
        ),
      ],
    );
  }
}
