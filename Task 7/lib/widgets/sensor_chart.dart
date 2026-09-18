import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';

class SensorChartWidget extends StatelessWidget {
  final List<AccelerometerData> data;

  const SensorChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final xSpots = <FlSpot>[];
    final ySpots = <FlSpot>[];
    final zSpots = <FlSpot>[];

    for (int i = 0; i < data.length; i++) {
      xSpots.add(FlSpot(i.toDouble(), data[i].x));
      ySpots.add(FlSpot(i.toDouble(), data[i].y));
      zSpots.add(FlSpot(i.toDouble(), data[i].z));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendBadge("X Axis", const Color(0xFFFF5252)),
            const SizedBox(width: 16),
            _buildLegendBadge("Y Axis", const Color(0xFF69F0AE)),
            const SizedBox(width: 16),
            _buildLegendBadge("Z Axis", const Color(0xFF448AFF)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 4,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.white.withValues(alpha: 0.1),
                  strokeWidth: 1,
                ),
              ),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: (data.length - 1).toDouble(),
              minY: -15,
              maxY: 15,
              lineBarsData: [
                LineChartBarData(
                  spots: xSpots,
                  isCurved: true,
                  color: const Color(0xFFFF5252),
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: ySpots,
                  isCurved: true,
                  color: const Color(0xFF69F0AE),
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: zSpots,
                  isCurved: true,
                  color: const Color(0xFF448AFF),
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendBadge(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
