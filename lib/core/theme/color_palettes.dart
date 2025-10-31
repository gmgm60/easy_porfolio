import 'package:flutter/material.dart';

import 'color_tokens.dart';


/// LIGHT THEME — derived from your screenshots
const AppColors lightAppColors = AppColors(
  // Brand
  primary: Color(0xFF3E6CB9),           // brand blue
  onPrimary: Color(0xFFFFFFFF),

  // Text
  textPrimary: Color(0xFF1C2B43),       // deep navy for titles/body
  textSecondary: Color(0xFF62728C),     // slate
  textMuted: Color(0xFF8693A7),         // placeholders / hints

  // Surfaces
  background: Color(0xFFA6AEBD),        // soft blue-gray page tint
  onBackground: Color(0xFF1C2B43),
  surface: Color(0xFFFFFFFF),           // cards / sheets
  onSurface: Color(0xFF1C2B43),
  surfaceVariant: Color(0xFFF1F6FD),    // inputs / subtle blocks
  onSurfaceVariant: Color(0xFF7989A3),

  // Borders & dividers
  border: Color(0x29AEB4BE),            // ~16% alpha hairline
  borderStrong: Color(0xFFDDDDDD),
  divider: Color(0xFFF3F3F3),

  // Status
  success: Color(0xFF46B93E),
  onSuccess: Color(0xFFFFFFFF),
  warning: Color(0xFFFFB74D),           // tasteful amber
  onWarning: Color(0xFF1C2B43),
  error: Color(0xFFE53935),
  onError: Color(0xFFFFFFFF),
  info: Color(0xFF3E6CB9),              // same family as primary
  onInfo: Color(0xFFFFFFFF),

  // Chips / Tags
  chipBackgroundInfo: Color(0xFFF1F6FD),   // “Customer” style
  chipBackgroundSuccess: Color(0xFFF7FFF7),// “Opportunities”
  chipBackgroundNeutral: Color(0xFFF8F8F8),
);

/// DARK THEME — keeps brand identity, boosts contrast & comfort
const AppColors darkAppColors = AppColors(
  // Brand
  primary: Color(0xFF6EA1FF),           // lifted for dark
  onPrimary: Color(0xFFFFFFFF),

  // Text
  textPrimary: Color(0xFFECEFF4),       // near-white
  textSecondary: Color(0xFFA6AEBD),     // cool gray-blue
  textMuted: Color(0xFF7989A3),

  // Surfaces
  background: Color(0xFF0F1217),        // deep slate (not pure black)
  onBackground: Color(0xFFECEFF4),
  surface: Color(0xFF151A22),           // cards / sheets
  onSurface: Color(0xFFECEFF4),
  surfaceVariant: Color(0xFF1C2431),    // inputs / subtle blocks
  onSurfaceVariant: Color(0xFFA6AEBD),

  // Borders & dividers
  border: Color(0x29FFFFFF),            // subtle hairline
  borderStrong: Color(0xFF566073),
  divider: Color(0xFF374B6D),

  // Status
  success: Color(0xFF46B93E),
  onSuccess: Color(0xFF0A0A0A),
  warning: Color(0xFFFFB74D),
  onWarning: Color(0xFF0A0A0A),
  error: Color(0xFFFF6B6B),
  onError: Color(0xFF0A0A0A),
  info: Color(0xFF6EA1FF),
  onInfo: Color(0xFF0A0A0A),

  // Chips / Tags (translucent tints over dark surfaces)
  chipBackgroundInfo: Color(0x143E6CB9),
  chipBackgroundSuccess: Color(0x1446B93E),
  chipBackgroundNeutral: Color(0x14FFFFFF),
);
