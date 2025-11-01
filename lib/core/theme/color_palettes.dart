import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:flutter/material.dart';

class LightPalette extends ColorPalette {
  const LightPalette();

  @override
  AppThemeType get themeType => AppThemeType.light;

  @override
  AppColors get colors => const AppColors(
    primary: Color(0xFF3E6CB9),
    onPrimary: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1C2B43),
    textSecondary: Color(0xFF62728C),
    textMuted: Color(0xFF8693A7),
    background: Color(0xFFA6AEBD),
    onBackground: Color(0xFF1C2B43),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1C2B43),
    surfaceVariant: Color(0xFFF1F6FD),
    onSurfaceVariant: Color(0xFF7989A3),
    border: Color(0x29AEB4BE),
    borderStrong: Color(0xFFDDDDDD),
    divider: Color(0xFFF3F3F3),
    success: Color(0xFF46B93E),
    onSuccess: Color(0xFFFFFFFF),
    warning: Color(0xFFFFB74D),
    onWarning: Color(0xFF1C2B43),
    error: Color(0xFFE53935),
    onError: Color(0xFFFFFFFF),
    info: Color(0xFF3E6CB9),
    onInfo: Color(0xFFFFFFFF),
    chipBackgroundInfo: Color(0xFFF1F6FD),
    chipBackgroundSuccess: Color(0xFFF7FFF7),
    chipBackgroundNeutral: Color(0xFFF8F8F8),
  );
}

class DarkPalette extends ColorPalette {
  const DarkPalette();

  @override
  AppThemeType get themeType => AppThemeType.dark;

  @override
  AppColors get colors => const AppColors(
    primary: Color(0xFF89A7FF),
    onPrimary: Color(0xFF0C0F18),
    textPrimary: Color(0xFFE8ECF4),
    textSecondary: Color(0xFFB7C0D1),
    textMuted: Color(0xFF95A0B5),
    background: Color(0xFF121420),
    onBackground: Color(0xFFE8ECF4),
    surface: Color(0xFF1A1E2B),
    onSurface: Color(0xFFE8ECF4),
    surfaceVariant: Color(0xFF222838),
    onSurfaceVariant: Color(0xFFB7C0D1),
    border: Color(0x292F3342),
    borderStrong: Color(0xFF3A4052),
    divider: Color(0xFF2A3042),
    success: Color(0xFF3CCB6B),
    onSuccess: Color(0xFF0D1B12),
    warning: Color(0xFFFFC46B),
    onWarning: Color(0xFF231B0A),
    error: Color(0xFFFF6B6B),
    onError: Color(0xFF230A0A),
    info: Color(0xFF89A7FF),
    onInfo: Color(0xFF0C0F18),
    chipBackgroundInfo: Color(0xFF242B3D),
    chipBackgroundSuccess: Color(0xFF1E2A22),
    chipBackgroundNeutral: Color(0xFF232838),
  );
}
