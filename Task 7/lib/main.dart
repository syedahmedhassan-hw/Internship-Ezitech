import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_provider.dart';
import 'providers/location_provider.dart';
import 'providers/qr_provider.dart';
import 'providers/sensor_provider.dart';

import 'screens/home_dashboard_screen.dart';
import 'screens/level_screen.dart';
import 'screens/location_screen.dart';
import 'screens/qr_studio_screen.dart';
import 'screens/sensor_screen.dart';
import 'screens/settings_screen.dart';

import 'widgets/custom_bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OmniSenseApp());
}

class OmniSenseApp extends StatelessWidget {
  const OmniSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SensorProvider()),
        ChangeNotifierProvider(create: (_) => QrProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProv, child) {
          return MaterialApp(
            title: 'OmniSense Pro',
            debugShowCheckedModeBanner: false,
            theme: themeProv.themeData,
            home: const MainShell(),
          );
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeDashboardScreen(onNavigate: _navigateTo),
      const LocationScreen(),
      const SensorScreen(),
      const LevelScreen(),
      const QrStudioScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _navigateTo,
      ),
    );
  }
}
