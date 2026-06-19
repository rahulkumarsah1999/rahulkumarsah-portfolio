import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.outfitTextTheme(),
  useMaterial3: true);

  // Dark Theme
static ThemeData darkTheme = ThemeData(brightness: Brightness.dark,
scaffoldBackgroundColor: const Color(0xFF121212),
  textTheme: GoogleFonts.outfitTextTheme(
    ThemeData.dark().textTheme,
  ),

useMaterial3: true,
);
}