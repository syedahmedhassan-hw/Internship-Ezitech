import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeMode { dark, light, cyberTeal, sunsetViolet }

class AppTheme {
  // Dark OLED Colors
  static const Color darkBg = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF131927);
  static const Color darkCard = Color(0xFF1B2338);
  static const Color primaryBlue = Color(0xFF388E3C);
  static const Color cyanAccent = Color(0xFF00E5FF);
  static const Color violetAccent = Color(0xFF7C4DFF);
  static const Color emeraldAccent = Color(0xFF00E676);
  static const Color amberAccent = Color(0xFFFFAB00);

  // Light Colors
  static const Color lightBg = Color(0xFFF4F6FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFEBF0FA);

  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return _buildTheme(
          brightness: Brightness.light,
          bg: lightBg,
          surface: lightSurface,
          card: lightCard,
          primary: const Color(0xFF2962FF),
          accent: const Color(0xFF00B0FF),
        );
      case AppThemeMode.cyberTeal:
        return _buildTheme(
          brightness: Brightness.dark,
          bg: const Color(0xFF05131A),
          surface: const Color(0xFF0A222D),
          card: const Color(0xFF103342),
          primary: const Color(0xFF00E5FF),
          accent: const Color(0xFF1DE9B6),
        );
      case AppThemeMode.sunsetViolet:
        return _buildTheme(
          brightness: Brightness.dark,
          bg: const Color(0xFF120B1C),
          surface: const Color(0xFF1D122E),
          card: const Color(0xFF2A1B43),
          primary: const Color(0xFFD500F9),
          accent: const Color(0xFFFF4081),
        );
      case AppThemeMode.dark:
        return _buildTheme(
          brightness: Brightness.dark,
          bg: darkBg,
          surface: darkSurface,
          card: darkCard,
          primary: cyanAccent,
          accent: violetAccent,
        );
    }
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color card,
    required Color primary,
    required Color accent,
  }) {
    final baseTextTheme = GoogleFonts.interTextTheme(
      brightness == Brightness.dark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: brightness == Brightness.dark ? Colors.black : Colors.white,
        secondary: accent,
        onSecondary: Colors.black,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: surface,
        onSurface: brightness == Brightness.dark ? Colors.white : Colors.black87,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: brightness == Brightness.dark ? Colors.white : Colors.black87,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: brightness == Brightness.dark ? Colors.white : Colors.black87,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: brightness == Brightness.dark ? Colors.white : Colors.black87,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.8)
              : Colors.black87,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: brightness == Brightness.dark ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
