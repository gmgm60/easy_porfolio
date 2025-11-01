import 'package:flutter/material.dart';

@immutable
class AppTypographyTokens extends ThemeExtension<AppTypographyTokens> {
  // Body
  final double bodySmall;
  final double bodyMedium;
  final double bodyLarge;

  // Titles
  final double titleSmall;
  final double titleMedium;
  final double titleLarge;

  // Headlines / Display
  final double headlineSmall;
  final double headlineMedium;
  final double headlineLarge;
  final double displaySmall;
  final double displayMedium;
  final double displayLarge;

  // Labels / Buttons
  final double labelSmall;
  final double labelMedium;
  final double labelLarge;
  final double buttonText;

  // Navigation & Special
  final double navigationTitle;
  final double navigationLargeTitle;
  final double actionText;
  final double pickerText;
  final double dateTimePickerText;
  final double caption;

  // Shared line height multiplier (you can add more if needed)
  final double lineHeight;

  const AppTypographyTokens({
    // body
    required this.bodySmall,
    required this.bodyMedium,
    required this.bodyLarge,
    // titles
    required this.titleSmall,
    required this.titleMedium,
    required this.titleLarge,
    // headlines / display
    required this.headlineSmall,
    required this.headlineMedium,
    required this.headlineLarge,
    required this.displaySmall,
    required this.displayMedium,
    required this.displayLarge,
    // labels / buttons
    required this.labelSmall,
    required this.labelMedium,
    required this.labelLarge,
    required this.buttonText,
    // navigation & special
    required this.navigationTitle,
    required this.navigationLargeTitle,
    required this.actionText,
    required this.pickerText,
    required this.dateTimePickerText,
    required this.caption,
    // shared
    required this.lineHeight,
  });

  @override
  AppTypographyTokens copyWith({
    double? bodySmall,
    double? bodyMedium,
    double? bodyLarge,
    double? titleSmall,
    double? titleMedium,
    double? titleLarge,
    double? headlineSmall,
    double? headlineMedium,
    double? headlineLarge,
    double? displaySmall,
    double? displayMedium,
    double? displayLarge,
    double? labelSmall,
    double? labelMedium,
    double? labelLarge,
    double? buttonText,
    double? navigationTitle,
    double? navigationLargeTitle,
    double? actionText,
    double? pickerText,
    double? dateTimePickerText,
    double? caption,
    double? lineHeight,
  }) {
    return AppTypographyTokens(
      bodySmall: bodySmall ?? this.bodySmall,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      titleSmall: titleSmall ?? this.titleSmall,
      titleMedium: titleMedium ?? this.titleMedium,
      titleLarge: titleLarge ?? this.titleLarge,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      displaySmall: displaySmall ?? this.displaySmall,
      displayMedium: displayMedium ?? this.displayMedium,
      displayLarge: displayLarge ?? this.displayLarge,
      labelSmall: labelSmall ?? this.labelSmall,
      labelMedium: labelMedium ?? this.labelMedium,
      labelLarge: labelLarge ?? this.labelLarge,
      buttonText: buttonText ?? this.buttonText,
      navigationTitle: navigationTitle ?? this.navigationTitle,
      navigationLargeTitle: navigationLargeTitle ?? this.navigationLargeTitle,
      actionText: actionText ?? this.actionText,
      pickerText: pickerText ?? this.pickerText,
      dateTimePickerText: dateTimePickerText ?? this.dateTimePickerText,
      caption: caption ?? this.caption,
      lineHeight: lineHeight ?? this.lineHeight,
    );
  }

  @override
  AppTypographyTokens lerp(ThemeExtension<AppTypographyTokens>? other, double t) {
    if (other is! AppTypographyTokens) {
      return this;
    }
    double l(double a, double b) => a + (b - a) * t;
    return AppTypographyTokens(
      bodySmall: l(bodySmall, other.bodySmall),
      bodyMedium: l(bodyMedium, other.bodyMedium),
      bodyLarge: l(bodyLarge, other.bodyLarge),
      titleSmall: l(titleSmall, other.titleSmall),
      titleMedium: l(titleMedium, other.titleMedium),
      titleLarge: l(titleLarge, other.titleLarge),
      headlineSmall: l(headlineSmall, other.headlineSmall),
      headlineMedium: l(headlineMedium, other.headlineMedium),
      headlineLarge: l(headlineLarge, other.headlineLarge),
      displaySmall: l(displaySmall, other.displaySmall),
      displayMedium: l(displayMedium, other.displayMedium),
      displayLarge: l(displayLarge, other.displayLarge),
      labelSmall: l(labelSmall, other.labelSmall),
      labelMedium: l(labelMedium, other.labelMedium),
      labelLarge: l(labelLarge, other.labelLarge),
      buttonText: l(buttonText, other.buttonText),
      navigationTitle: l(navigationTitle, other.navigationTitle),
      navigationLargeTitle: l(navigationLargeTitle, other.navigationLargeTitle),
      actionText: l(actionText, other.actionText),
      pickerText: l(pickerText, other.pickerText),
      dateTimePickerText: l(dateTimePickerText, other.dateTimePickerText),
      caption: l(caption, other.caption),
      lineHeight: l(lineHeight, other.lineHeight),
    );
  }
}


///  mobile (≥390 and <650)
const mobileTypography = AppTypographyTokens(
  bodySmall: 12, bodyMedium: 15, bodyLarge: 16,
  titleSmall: 15, titleMedium: 17, titleLarge: 21,
  headlineSmall: 20, headlineMedium: 24, headlineLarge: 28,
  displaySmall: 32, displayMedium: 36, displayLarge: 40,
  labelSmall: 11, labelMedium: 13, labelLarge: 15,
  buttonText: 14,
  navigationTitle: 18,
  navigationLargeTitle: 32,
  actionText: 15,
  pickerText: 18,
  dateTimePickerText: 18,
  caption: 12,
  lineHeight: 1.24,
);

/// tablet (≥650 and <1364 — tablets)
const tabletTypography = AppTypographyTokens(
  bodySmall: 13, bodyMedium: 16, bodyLarge: 18,
  titleSmall: 16, titleMedium: 18, titleLarge: 22,
  headlineSmall: 24, headlineMedium: 26, headlineLarge: 30,
  displaySmall: 34, displayMedium: 38, displayLarge: 44,
  labelSmall: 11, labelMedium: 13, labelLarge: 16,
  buttonText: 16,
  navigationTitle: 20,
  navigationLargeTitle: 36,
  actionText: 16,
  pickerText: 18,
  dateTimePickerText: 18,
  caption: 12,
  lineHeight: 1.26,
);

/// Desktops (≥1364 — desktops)
const desktopTypography = AppTypographyTokens(
  bodySmall: 14, bodyMedium: 18, bodyLarge: 20,
  titleSmall: 18, titleMedium: 20, titleLarge: 24,
  headlineSmall: 24, headlineMedium: 28, headlineLarge: 32,
  displaySmall: 38, displayMedium: 44, displayLarge: 52,
  labelSmall: 12, labelMedium: 14, labelLarge: 18,
  buttonText: 18,
  navigationTitle: 22,
  navigationLargeTitle: 40,
  actionText: 18,
  pickerText: 20,
  dateTimePickerText: 20,
  caption: 13,
  lineHeight: 1.3,
);
