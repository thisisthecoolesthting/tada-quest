import 'package:flutter/material.dart';

/// Tada Quest brand palette — bright, high-contrast, kid-friendly.
class TQColors {
  static const purple = Color(0xFF6C4AB6);
  static const purpleDeep = Color(0xFF4B2E83);
  static const sky = Color(0xFF34C6F4);
  static const sun = Color(0xFFFFC23C);
  static const coral = Color(0xFFFF6B6B);
  static const mint = Color(0xFF3DD598);
  static const cream = Color(0xFFFFF7E8);
  static const ink = Color(0xFF2B2240);
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: TQColors.purple,
        primary: TQColors.purple,
        secondary: TQColors.sky,
        surface: TQColors.cream,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: TQColors.cream,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: TQColors.ink,
        displayColor: TQColors.ink,
        fontSizeFactor: 1.05,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TQColors.purple,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(64), // large tap target
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: TQColors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
