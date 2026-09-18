import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/sensor_provider.dart';

import '../widgets/glass_card.dart';
import '../widgets/sound_meter_widget.dart';

class HomeDashboardScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeDashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final locationProv = Provider.of<LocationProvider>(context);
    final sensorProv = Provider.of<SensorProvider>(context);
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bolt_rounded, color: primary, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("OmniSense Pro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  "TELEMETRY HUB",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: primary, letterSpacing: 1.2),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => onNavigate(5),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary.withValues(alpha: 0.2), const Color(0xFF7C4DFF).withValues(alpha: 0.2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                            const Text(
                              "SYSTEM ACTIVE",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00E676),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Precision Mobile Sensors & Spatial Suite",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          locationProv.useSimulation || sensorProv.useSimulation
                              ? "Running in Live Telemetry Simulation Mode"
                              : "Connected to Native Device Hardware Sensors",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.sensors, size: 42, color: Color(0xFF00E5FF)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hero Grid 1: GPS Location Card
            GlassCard(
              onTap: () => onNavigate(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: Color(0xFFFF5252), size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Real-Time GPS Location",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text("Open Map →", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricTile(
                          "LATITUDE",
                          locationProv.currentLocation.latitude.toStringAsFixed(5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricTile(
                          "LONGITUDE",
                          locationProv.currentLocation.longitude.toStringAsFixed(5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricTile(
                          "ALTITUDE",
                          "${locationProv.currentLocation.altitude.toStringAsFixed(1)}m",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "📍 ${locationProv.currentLocation.formattedAddress}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hero Grid 2: Sensors & Spirit Level Row
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    onTap: () => onNavigate(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.show_chart, color: Color(0xFF69F0AE), size: 18),
                            SizedBox(width: 6),
                            Text("Accelerometer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "X: ${sensorProv.currentAccelerometer.x.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                        ),
                        Text(
                          "Y: ${sensorProv.currentAccelerometer.y.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                        ),
                        Text(
                          "Z: ${sensorProv.currentAccelerometer.z.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassCard(
                    onTap: () => onNavigate(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.crop_free,
                              color: sensorProv.spiritLevel.isLevel
                                  ? const Color(0xFF00E676)
                                  : const Color(0xFFFFAB00),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            const Text("Spirit Level", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Pitch: ${sensorProv.spiritLevel.pitch.toStringAsFixed(1)}°",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Roll: ${sensorProv.spiritLevel.roll.toStringAsFixed(1)}°",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          sensorProv.spiritLevel.isLevel ? "Status: Level" : "Status: Tilted",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: sensorProv.spiritLevel.isLevel
                                ? const Color(0xFF00E676)
                                : const Color(0xFFFFAB00),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hero Grid 3: QR Studio Quick Actions
            GlassCard(
              onTap: () => onNavigate(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.qr_code_2, color: Color(0xFF7C4DFF), size: 22),
                      SizedBox(width: 8),
                      Text("QR Code Utility Studio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onNavigate(4),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text("Generate QR"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary.withValues(alpha: 0.2),
                            foregroundColor: primary,
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onNavigate(4),
                          icon: const Icon(Icons.qr_code_scanner, size: 18),
                          label: const Text("Scan Code"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                            foregroundColor: const Color(0xFF7C4DFF),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ambient Sound Monitor
            GlassCard(
              child: SoundMeterWidget(soundData: sensorProv.soundLevel),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
