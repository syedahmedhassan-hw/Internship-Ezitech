import 'dart:math';
import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';

class SpiritLevelWidget extends StatelessWidget {
  final SpiritLevelData levelData;
  final VoidCallback? onCalibrate;
  final VoidCallback? onReset;

  const SpiritLevelWidget({
    super.key,
    required this.levelData,
    this.onCalibrate,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final isLevel = levelData.isLevel;
    final levelColor = isLevel ? const Color(0xFF00E676) : const Color(0xFF00E5FF);

    return Column(
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(240, 240),
                painter: _SpiritLevelPainter(
                  pitch: levelData.pitch,
                  roll: levelData.roll,
                  isLevel: isLevel,
                  accentColor: levelColor,
                ),
              ),
              if (isLevel)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF00E676), width: 1.5),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF00E676), size: 16),
                      SizedBox(width: 4),
                      Text(
                        "PERFECT LEVEL",
                        style: TextStyle(
                          color: Color(0xFF00E676),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAngleTile("PITCH (X)", "${levelData.pitch.toStringAsFixed(1)}°", Icons.height),
            _buildAngleTile("ROLL (Y)", "${levelData.roll.toStringAsFixed(1)}°", Icons.rotate_right),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: onCalibrate,
              icon: const Icon(Icons.tune, size: 18),
              label: const Text("Zero Calibrate"),
            ),
            if (levelData.isCalibrated) ...[
              const SizedBox(width: 12),
              IconButton.outlined(
                onPressed: onReset,
                icon: const Icon(Icons.refresh, size: 18),
                tooltip: "Reset Calibration",
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildAngleTile(String label, String value, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SpiritLevelPainter extends CustomPainter {
  final double pitch;
  final double roll;
  final bool isLevel;
  final Color accentColor;

  _SpiritLevelPainter({
    required this.pitch,
    required this.roll,
    required this.isLevel,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer Circle
    final outerPaint = Paint();
    outerPaint.color = Colors.white.withOpacity(0.05);
    outerPaint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, outerPaint);

    final borderPaint = Paint();
    borderPaint.color = accentColor.withOpacity(isLevel ? 0.8 : 0.3);
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 3.0;
    canvas.drawCircle(center, radius - 2, borderPaint);

    // Target Rings
    final innerRingPaint = Paint();
    innerRingPaint.color = Colors.white.withOpacity(0.15);
    innerRingPaint.style = PaintingStyle.stroke;
    innerRingPaint.strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.6, innerRingPaint);
    canvas.drawCircle(center, radius * 0.25, innerRingPaint);

    // Crosshair Lines
    final linePaint = Paint();
    linePaint.color = Colors.white.withOpacity(0.2);
    linePaint.strokeWidth = 1.5;
    canvas.drawLine(Offset(center.dx - radius, center.dy), Offset(center.dx + radius, center.dy), linePaint);
    canvas.drawLine(Offset(center.dx, center.dy - radius), Offset(center.dx, center.dy + radius), linePaint);

    // Calculate Bubble Position based on pitch and roll
    final maxDisplacement = radius - 30.0;
    double dx = (roll / 45.0) * maxDisplacement;
    double dy = (pitch / 45.0) * maxDisplacement;

    final distance = sqrt(dx * dx + dy * dy);
    if (distance > maxDisplacement) {
      dx = (dx / distance) * maxDisplacement;
      dy = (dy / distance) * maxDisplacement;
    }

    final bubbleCenter = Offset(center.dx + dx, center.dy + dy);

    // Draw Bubble with glowing effect
    final bubbleGlowPaint = Paint();
    bubbleGlowPaint.color = accentColor.withOpacity(0.4);
    bubbleGlowPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawCircle(bubbleCenter, 22, bubbleGlowPaint);

    final bubblePaint = Paint();
    bubblePaint.color = accentColor;
    bubblePaint.style = PaintingStyle.fill;
    canvas.drawCircle(bubbleCenter, 18, bubblePaint);

    // Inner Specular Reflection Dot
    final reflectionPaint = Paint();
    reflectionPaint.color = Colors.white.withOpacity(0.8);
    reflectionPaint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(bubbleCenter.dx - 4, bubbleCenter.dy - 4), 4, reflectionPaint);
  }

  @override
  bool shouldRepaint(covariant _SpiritLevelPainter oldDelegate) {
    return oldDelegate.pitch != pitch ||
        oldDelegate.roll != roll ||
        oldDelegate.isLevel != isLevel ||
        oldDelegate.accentColor != accentColor;
  }
}
