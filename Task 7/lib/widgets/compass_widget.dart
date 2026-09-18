import 'dart:math';
import 'package:flutter/material.dart';

class CompassWidget extends StatelessWidget {
  final double heading;

  const CompassWidget({super.key, required this.heading});

  String get cardinalDirection {
    if (heading >= 337.5 || heading < 22.5) return "N";
    if (heading >= 22.5 && heading < 67.5) return "NE";
    if (heading >= 67.5 && heading < 112.5) return "E";
    if (heading >= 112.5 && heading < 157.5) return "SE";
    if (heading >= 157.5 && heading < 202.5) return "S";
    if (heading >= 202.5 && heading < 247.5) return "SW";
    if (heading >= 247.5 && heading < 292.5) return "W";
    return "NW";
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 170,
        height: 170,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -heading * (pi / 180),
              child: CustomPaint(
                size: const Size(170, 170),
                painter: _CompassDialPainter(),
              ),
            ),
            // Fixed Top Pointer Pin
            Positioned(
              top: 6,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5252),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Center Display
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${heading.round()}°",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  cardinalDirection,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00E5FF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassDialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint();
    bgPaint.color = Colors.white.withOpacity(0.04);
    bgPaint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    final ringPaint = Paint();
    ringPaint.color = Colors.white.withOpacity(0.15);
    ringPaint.style = PaintingStyle.stroke;
    ringPaint.strokeWidth = 2.0;
    canvas.drawCircle(center, radius - 4, ringPaint);

    // Draw Ticks for every 15 degrees
    final tickPaint = Paint();
    tickPaint.color = Colors.white.withOpacity(0.3);
    tickPaint.strokeWidth = 1.2;

    final majorTickPaint = Paint();
    majorTickPaint.color = Colors.white.withOpacity(0.8);
    majorTickPaint.strokeWidth = 2.0;

    for (int i = 0; i < 360; i += 15) {
      final angle = i * (pi / 180);
      final isMajor = i % 90 == 0;
      final tickLength = isMajor ? 10.0 : 6.0;

      final inner = Offset(
        center.dx + (radius - 10 - tickLength) * sin(angle),
        center.dy - (radius - 10 - tickLength) * cos(angle),
      );
      final outer = Offset(
        center.dx + (radius - 10) * sin(angle),
        center.dy - (radius - 10) * cos(angle),
      );

      canvas.drawLine(inner, outer, isMajor ? majorTickPaint : tickPaint);
    }

    // Draw N, E, S, W Labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    void drawCardinalText(String text, double angle, Color color) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();

      final textPos = Offset(
        center.dx + (radius - 28) * sin(angle) - textPainter.width / 2,
        center.dy - (radius - 28) * cos(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textPos);
    }

    drawCardinalText("N", 0, const Color(0xFFFF5252));
    drawCardinalText("E", pi / 2, Colors.white);
    drawCardinalText("S", pi, Colors.white);
    drawCardinalText("W", 3 * pi / 2, Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
