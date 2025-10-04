
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0A84FF);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color onSurfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceVariantColor = Color(0xFFBDBDBD);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      dividerColor: Colors.grey[800],
      
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: onSurfaceColor),
        titleTextStyle: GoogleFonts.montserrat(
          color: onSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: onSurfaceColor,
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: onSurfaceColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.openSans(
          color: onSurfaceColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.openSans(
          color: onSurfaceVariantColor,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.montserrat(
          color: onSurfaceColor,
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
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceVariantColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
