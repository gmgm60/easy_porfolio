import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@immutable
class SpacingTokens extends ThemeExtension<SpacingTokens> {
  // Scalar spacing values
  final double spacing4;
  final double spacing8;
  final double spacing10;
  final double spacing12;
  final double spacing16;
  final double spacing23;
  final double spacing24;

  const SpacingTokens({
    required this.spacing4,
    required this.spacing8,
    required this.spacing10,
    required this.spacing12,
    required this.spacing16,
    required this.spacing23,
    required this.spacing24,
  });

  // Semantic aliases
  double get xs => spacing4;
  double get sm => spacing8;
  double get md => spacing16;
  double get lg => spacing24;

  // Padding helpers (keep usage consistent)
  EdgeInsets get pAll4  => EdgeInsets.all(spacing4);
  EdgeInsets get pAll8  => EdgeInsets.all(spacing8);
  EdgeInsets get pAll10 => EdgeInsets.all(spacing10);
  EdgeInsets get pAll12 => EdgeInsets.all(spacing12);
  EdgeInsets get pAll16 => EdgeInsets.all(spacing16);
  EdgeInsets get pAll23 => EdgeInsets.all(spacing23);
  EdgeInsets get pAll24 => EdgeInsets.all(spacing24);

  // Gap helpers (Widget) — using `Gap` instead of `SizedBox`
  Gap get gap4  => Gap(spacing4);
  Gap get gap8  => Gap(spacing8);
  Gap get gap10 => Gap(spacing10);
  Gap get gap12 => Gap(spacing12);
  Gap get gap16 => Gap(spacing16);
  Gap get gap23 => Gap(spacing23);
  Gap get gap24 => Gap(spacing24);

  @override
  SpacingTokens copyWith({
    double? spacing4,
    double? spacing8,
    double? spacing10,
    double? spacing12,
    double? spacing16,
    double? spacing23,
    double? spacing24,
  }) => SpacingTokens(
    spacing4:  spacing4  ?? this.spacing4,
    spacing8:  spacing8  ?? this.spacing8,
    spacing10: spacing10 ?? this.spacing10,
    spacing12: spacing12 ?? this.spacing12,
    spacing16: spacing16 ?? this.spacing16,
    spacing23: spacing23 ?? this.spacing23,
    spacing24: spacing24 ?? this.spacing24,
  );

  @override
  SpacingTokens lerp(ThemeExtension<SpacingTokens>? other, double t) {
    if (other is! SpacingTokens) return this;
    double l(double a, double b) => a + (b - a) * t;
    return SpacingTokens(
      spacing4:  l(spacing4,  other.spacing4),
      spacing8:  l(spacing8,  other.spacing8),
      spacing10: l(spacing10, other.spacing10),
      spacing12: l(spacing12, other.spacing12),
      spacing16: l(spacing16, other.spacing16),
      spacing23: l(spacing23, other.spacing23),
      spacing24: l(spacing24, other.spacing24),
    );
  }
}

// Defaults (mobile baseline)
const mobileSpacingTokens = SpacingTokens(
  spacing4: 4,
  spacing8: 8,
  spacing10: 10,
  spacing12: 12,
  spacing16: 16,
  spacing23: 23,
  spacing24: 24,
);

const tabletSpacingTokens = SpacingTokens(
  spacing4: 4,
  spacing8: 8,
  spacing10: 10,
  spacing12: 12,
  spacing16: 16,
  spacing23: 23,
  spacing24: 24,
);

const desktopSpacingTokens = SpacingTokens(
  spacing4: 4,
  spacing8: 8,
  spacing10: 10,
  spacing12: 12,
  spacing16: 16,
  spacing23: 23,
  spacing24: 24,
);

