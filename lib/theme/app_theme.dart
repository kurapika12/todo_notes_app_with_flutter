import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color black = Color(0xFF1A1A1A);
  static const Color darkGrey = Color(0xFF2C2C2C);
  static const Color lightGrey = Color(0xFFF2F2F2);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    primaryColor: black,
    colorScheme: const ColorScheme.light(
      primary: black,
      secondary: darkGrey,
      surface: white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: black,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: white,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: black,
      foregroundColor: white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: white,
      indicatorColor: black.withOpacity(0.08),
      surfaceTintColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: black,
    primaryColor: white,
    colorScheme: const ColorScheme.dark(
      primary: white,
      secondary: lightGrey,
      surface: darkGrey,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      foregroundColor: white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: darkGrey,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade800),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: white,
      foregroundColor: black,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: black,
      indicatorColor: white.withOpacity(0.12),
      surfaceTintColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // Pilihan warna label untuk kategori catatan (tetap berwarna biar catatan mudah dibedakan)
  static const List<Color> noteLabelColors = [
    Color(0xFF9E9E9E), // abu (default/none)
    Color(0xFFEF9A9A), // merah muda
    Color(0xFFFFCC80), // orange
    Color(0xFFFFF59D), // kuning
    Color(0xFFA5D6A7), // hijau
    Color(0xFF90CAF9), // biru
    Color(0xFFCE93D8), // ungu
  ];
}
