import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_provider.dart';
import '../providers/location_provider.dart';
import '../providers/qr_provider.dart';
import '../providers/sensor_provider.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final locationProv = Provider.of<LocationProvider>(context);
    final sensorProv = Provider.of<SensorProvider>(context);
    final qrProv = Provider.of<QrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Customization"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "THEME & VISUAL STYLE",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: AppThemeMode.values.map((mode) {
                  return RadioListTile<AppThemeMode>(
                    title: Text(_getThemeName(mode)),
                    subtitle: Text(_getThemeDescription(mode)),
                    value: mode,
                    groupValue: themeProv.currentThemeMode,
                    onChanged: (val) {
                      if (val != null) themeProv.setThemeMode(val);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "TELEMETRY & SENSOR OPTIONS",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text("GPS Simulation Mode"),
                    subtitle: const Text("Use simulated location coordinates when native GPS is unavailable"),
                    value: locationProv.useSimulation,
                    onChanged: (val) => locationProv.toggleSimulationMode(val),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text("Motion Sensor Simulation"),
                    subtitle: const Text("Simulate 3-axis accelerometer and compass data streams"),
                    value: sensorProv.useSimulation,
                    onChanged: (val) => sensorProv.toggleSimulationMode(val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "DATA & STORAGE MANAGEMENT",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.qr_code_2_outlined),
                    title: const Text("Clear QR History"),
                    subtitle: Text("${qrProv.qrHistory.length} saved QR items"),
                    trailing: TextButton(
                      onPressed: () {
                        qrProv.clearHistory();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("QR history cleared.")),
                        );
                      },
                      child: const Text("Clear", style: TextStyle(color: Colors.redAccent)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About App Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("OmniSense Pro", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("v1.0.0 (Industry Telemetry Edition)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Built with Flutter Material 3, Geolocator GPS, SensorsPlus, OpenStreetMap, and fl_chart.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return "Midnight OLED Dark";
      case AppThemeMode.light:
        return "Clean Material Light";
      case AppThemeMode.cyberTeal:
        return "Cyber Neon Teal";
      case AppThemeMode.sunsetViolet:
        return "Sunset Electric Violet";
    }
  }

  String _getThemeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return "High contrast dark palette with cyan and violet accents";
      case AppThemeMode.light:
        return "Bright, crisp white theme for outdoor readability";
      case AppThemeMode.cyberTeal:
        return "Deep ocean background with electric cyan indicators";
      case AppThemeMode.sunsetViolet:
        return "Deep purple OLED background with magenta glows";
    }
  }
}
