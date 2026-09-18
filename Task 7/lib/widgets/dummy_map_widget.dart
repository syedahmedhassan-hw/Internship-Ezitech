import 'package:flutter/material.dart';

class SpatialRadarMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String label;

  const SpatialRadarMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.label = "Current Position",
  });

  @override
  State<SpatialRadarMapWidget> createState() => _SpatialRadarMapWidgetState();
}

class _SpatialRadarMapWidgetState extends State<SpatialRadarMapWidget> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  double _zoomLevel = 1.0;
  bool _isSatelliteMode = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        // Custom Painted Spatial Grid Map
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _RadarMapPainter(
                pulseVal: _pulseController.value,
                zoomLevel: _zoomLevel,
                isSatellite: _isSatelliteMode,
                primaryColor: primary,
                lat: widget.latitude,
                lng: widget.longitude,
              ),
            );
          },
        ),

        // Live Telemetry Badge Top-Left
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primary.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00E676),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${widget.latitude.toStringAsFixed(4)}°, ${widget.longitude.toStringAsFixed(4)}°",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ),

        // Map Control Buttons Top-Right
        Positioned(
          top: 12,
          right: 12,
          child: Column(
            children: [
              _buildControlButton(
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    if (_zoomLevel < 2.5) _zoomLevel += 0.3;
                  });
                },
              ),
              const SizedBox(height: 6),
              _buildControlButton(
                icon: Icons.remove,
                onTap: () {
                  setState(() {
                    if (_zoomLevel > 0.6) _zoomLevel -= 0.3;
                  });
                },
              ),
              const SizedBox(height: 6),
              _buildControlButton(
                icon: _isSatelliteMode ? Icons.map : Icons.satellite_alt,
                onTap: () {
                  setState(() {
                    _isSatelliteMode = !_isSatelliteMode;
                  });
                },
              ),
            ],
          ),
        ),

        // Bottom Map Mode Label
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _isSatelliteMode ? "🛰️ Satellite Vector View" : "🗺️ GeoSense Spatial Map",
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _RadarMapPainter extends CustomPainter {
  final double pulseVal;
  final double zoomLevel;
  final bool isSatellite;
  final Color primaryColor;
  final double lat;
  final double lng;

  _RadarMapPainter({
    required this.pulseVal,
    required this.zoomLevel,
    required this.isSatellite,
    required this.primaryColor,
    required this.lat,
    required this.lng,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final bgPaint = Paint();
    bgPaint.color = isSatellite ? const Color(0xFF07141C) : const Color(0xFF0D1B2A);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Draw Grid Lines (Latitude & Longitude lines)
    final gridPaint = Paint();
    gridPaint.color = isSatellite
        ? const Color(0xFF103342).withOpacity(0.4)
        : Colors.white.withOpacity(0.06);
    gridPaint.strokeWidth = 1.0;

    final gridSpacing = 40.0 * zoomLevel;

    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw Vector Terrain Contours / Road Simulation Lines
    final roadPaint = Paint();
    roadPaint.color = isSatellite
        ? const Color(0xFF1E4D61).withOpacity(0.5)
        : primaryColor.withOpacity(0.15);
    roadPaint.strokeWidth = 2.0;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.3);
    path1.quadraticBezierTo(size.width * 0.4, size.height * 0.1, size.width, size.height * 0.5);
    canvas.drawPath(path1, roadPaint);

    final path2 = Path();
    path2.moveTo(size.width * 0.2, 0);
    path2.quadraticBezierTo(size.width * 0.5, size.height * 0.7, size.width * 0.8, size.height);
    canvas.drawPath(path2, roadPaint);

    // Draw Concentric Radar Signal Rings around Pin
    final ringPaint = Paint();
    ringPaint.style = PaintingStyle.stroke;
    ringPaint.strokeWidth = 1.5;

    for (int r = 1; r <= 3; r++) {
      double currentRadius = (r * 40.0 * zoomLevel);
      ringPaint.color = primaryColor.withOpacity(0.15 / r);
      canvas.drawCircle(center, currentRadius, ringPaint);
    }

    // Draw Pulsing User Radar Wave
    final pulseRadius = (60.0 * pulseVal * zoomLevel);
    final pulsePaint = Paint();
    pulsePaint.color = primaryColor.withOpacity((1.0 - pulseVal) * 0.4);
    pulsePaint.style = PaintingStyle.stroke;
    pulsePaint.strokeWidth = 2.0;
    canvas.drawCircle(center, pulseRadius, pulsePaint);

    // Center Pin Marker Glowing Aura
    final pinGlowPaint = Paint();
    pinGlowPaint.color = primaryColor.withOpacity(0.5);
    canvas.drawCircle(center, 14, pinGlowPaint);

    final pinCorePaint = Paint();
    pinCorePaint.color = primaryColor;
    canvas.drawCircle(center, 8, pinCorePaint);

    final pinDotPaint = Paint();
    pinDotPaint.color = Colors.white;
    canvas.drawCircle(center, 3, pinDotPaint);

    // Draw Crosshair Marks
    final crossPaint = Paint();
    crossPaint.color = primaryColor.withOpacity(0.7);
    crossPaint.strokeWidth = 1.5;

    canvas.drawLine(Offset(center.dx - 12, center.dy), Offset(center.dx - 5, center.dy), crossPaint);
    canvas.drawLine(Offset(center.dx + 5, center.dy), Offset(center.dx + 12, center.dy), crossPaint);
    canvas.drawLine(Offset(center.dx, center.dy - 12), Offset(center.dx, center.dy - 5), crossPaint);
    canvas.drawLine(Offset(center.dx, center.dy + 5), Offset(center.dx, center.dy + 12), crossPaint);
  }

  @override
  bool shouldRepaint(covariant _RadarMapPainter oldDelegate) {
    return oldDelegate.pulseVal != pulseVal ||
        oldDelegate.zoomLevel != zoomLevel ||
        oldDelegate.isSatellite != isSatellite ||
        oldDelegate.lat != lat ||
        oldDelegate.lng != lng;
  }
}
