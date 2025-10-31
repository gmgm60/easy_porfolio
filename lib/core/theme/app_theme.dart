
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0A84FF);

  // Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkOnSurfaceColor = Color(0xFFFFFFFF);
  static const Color darkOnSurfaceVariantColor = Color(0xFFBDBDBD);

  // Light Theme Colors
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightSurfaceColor = Color(0xFFF0F0F0);
  static const Color lightOnSurfaceColor = Color(0xFF212121);
  static const Color lightOnSurfaceVariantColor = Color(0xFF616161);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkSurfaceColor,
      dividerColor: Colors.grey[800],
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkOnSurfaceColor),
        titleTextStyle: GoogleFonts.montserrat(
          color: darkOnSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: darkOnSurfaceColor,
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: darkOnSurfaceColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.openSans(
          color: darkOnSurfaceColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.openSans(
          color: darkOnSurfaceVariantColor,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.montserrat(
          color: darkOnSurfaceColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: darkOnSurfaceVariantColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      cardColor: lightSurfaceColor,
      dividerColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: lightOnSurfaceColor),
        titleTextStyle: GoogleFonts.montserrat(
          color: lightOnSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: lightOnSurfaceColor,
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: lightOnSurfaceColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.openSans(
          color: lightOnSurfaceColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.openSans(
          color: lightOnSurfaceVariantColor,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.montserrat(
          color: lightOnSurfaceColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightOnSurfaceVariantColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
