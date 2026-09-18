import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _currentThemeMode = AppThemeMode.dark;

  AppThemeMode get currentThemeMode => _currentThemeMode;

  ThemeData get themeData => AppTheme.getTheme(_currentThemeMode);

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  void setThemeMode(AppThemeMode mode) async {
    _currentThemeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme_mode', mode.name);
  }

  void _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedModeStr = prefs.getString('app_theme_mode');
    if (savedModeStr != null) {
      _currentThemeMode = AppThemeMode.values.firstWhere(
        (e) => e.name == savedModeStr,
        orElse: () => AppThemeMode.dark,
      );
      notifyListeners();
    }
  }
}
