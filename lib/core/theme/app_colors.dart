import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/core/theme/color_palettes.dart';
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // ---- Brand ----
  final Color primary; // Brand blue (buttons, accents)
  final Color onPrimary; // Text/icon on primary

  // ---- Text ----
  final Color textPrimary; // Main body/title text
  final Color textSecondary; // Secondary text / helper
  final Color textMuted; // Disabled/placeholder

  // ---- Surfaces & backgrounds ----
  final Color background; // Page background
  final Color onBackground; // Text/icon on background
  final Color surface; // Cards, sheets
  final Color onSurface; // Text/icon on surface
  final Color surfaceVariant; // Subtle surface (search box, chips, etc.)
  final Color onSurfaceVariant; // Text/icon on variant surface

  // ---- Borders & dividers ----
  final Color border; // Subtle 1px borders (card, list, input)
  final Color borderStrong; // Stronger outline when needed
  final Color divider; // Horizontal separators

  // ---- Status ----
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color error;
  final Color onError;
  final Color info; // Informational accent (often same family as primary)
  final Color onInfo;

  // ---- Tag/Chip backgrounds ----
  final Color chipBackgroundInfo; // e.g. “Customer” pill
  final Color chipBackgroundSuccess; // e.g. “Opportunities” pill
  final Color chipBackgroundNeutral; // gray/neutral pill background

  const AppColors({
    // Brand
    required this.primary,
    required this.onPrimary,

    // Text
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,

    // Surfaces
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,

    // Borders
    required this.border,
    required this.borderStrong,
    required this.divider,

    // Status
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.error,
    required this.onError,
    required this.info,
    required this.onInfo,

    // Chips
    required this.chipBackgroundInfo,
    required this.chipBackgroundSuccess,
    required this.chipBackgroundNeutral,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? border,
    Color? borderStrong,
    Color? divider,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? error,
    Color? onError,
    Color? info,
    Color? onInfo,
    Color? chipBackgroundInfo,
    Color? chipBackgroundSuccess,
    Color? chipBackgroundNeutral,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,

      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,

      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,

      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      divider: divider ?? this.divider,

      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,

      chipBackgroundInfo: chipBackgroundInfo ?? this.chipBackgroundInfo,
      chipBackgroundSuccess:
          chipBackgroundSuccess ?? this.chipBackgroundSuccess,
      chipBackgroundNeutral:
          chipBackgroundNeutral ?? this.chipBackgroundNeutral,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;

    return AppColors(
      // Brand
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),

      // Text
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textMuted: l(textMuted, other.textMuted),

      // Surfaces
      background: l(background, other.background),
      onBackground: l(onBackground, other.onBackground),
      surface: l(surface, other.surface),
      onSurface: l(onSurface, other.onSurface),
      surfaceVariant: l(surfaceVariant, other.surfaceVariant),
      onSurfaceVariant: l(onSurfaceVariant, other.onSurfaceVariant),

      // Borders
      border: l(border, other.border),
      borderStrong: l(borderStrong, other.borderStrong),
      divider: l(divider, other.divider),

      // Status
      success: l(success, other.success),
      onSuccess: l(onSuccess, other.onSuccess),
      warning: l(warning, other.warning),
      onWarning: l(onWarning, other.onWarning),
      error: l(error, other.error),
      onError: l(onError, other.onError),
      info: l(info, other.info),
      onInfo: l(onInfo, other.onInfo),

      // Chips
      chipBackgroundInfo: l(chipBackgroundInfo, other.chipBackgroundInfo),
      chipBackgroundSuccess: l(
        chipBackgroundSuccess,
        other.chipBackgroundSuccess,
      ),
      chipBackgroundNeutral: l(
        chipBackgroundNeutral,
        other.chipBackgroundNeutral,
      ),
    );
  }
}

/// Abstraction: every palette must provide tokens + brightness.
abstract class ColorPalette {
  const ColorPalette();

  static final List<ColorPalette> all = [
    const LightPalette(),
    const DarkPalette(),
  ];

  /// Color tokens for this palette.
  AppColors get colors;

  AppThemeType get themeType;

  /// Overall brightness inferred from the background (AMOLED/sepia supported).
  Brightness get brightness =>
      ThemeData.estimateBrightnessForColor(colors.background);
}
