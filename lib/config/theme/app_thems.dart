import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  return ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    textTheme: GoogleFonts.abelTextTheme(
      const TextTheme(
        bodySmall: TextStyle(color: Colors.grey),
        bodyMedium: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.grey),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    textTheme: GoogleFonts.abelTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.grey),
      ),
    ),
  );
}
