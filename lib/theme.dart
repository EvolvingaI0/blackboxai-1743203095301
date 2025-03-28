import 'package:flutter/material.dart';

final ThemeData auroraTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.cyanAccent,
    surface: const Color(0xFF121212),
    background: const Color(0xFF121212),
    error: Colors.redAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      letterSpacing: 0.25,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  useMaterial3: true,
);

class AuroraColors {
  static const Color primary = Color(0xFF00B4D8);
  static const Color secondary = Color(0xFF0077B6);
  static const Color accent = Color(0xFF90E0EF);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color error = Color(0xFFCF6679);
}