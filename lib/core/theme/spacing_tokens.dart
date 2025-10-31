// lib/theme/spacing_tokens.dart
import 'package:flutter/material.dart';

@immutable
class SpacingTokens extends ThemeExtension<SpacingTokens> {
  // Scalar spacing values (keep your exact set)
  final double spacing4;
  final double spacing8;
  final double spacing10;
  final double spacing12;
  final double spacing16;
  final double spacing23;
  final double spacing24;

  // Optional semantic aliases (readable names, map them to your numeric scale)
  double get spacingSmall        => spacing8;
  double get spacingMedium       => spacing16;
  double get spacingLarge        => spacing24;
  double get spacingExtraSmall   => spacing4;

  // Common EdgeInsets helpers (so call sites stay clean & consistent)
  EdgeInsets get paddingAll4   => EdgeInsets.all(spacing4);
  EdgeInsets get paddingAll8   => EdgeInsets.all(spacing8);
  EdgeInsets get paddingAll10  => EdgeInsets.all(spacing10);
  EdgeInsets get paddingAll12  => EdgeInsets.all(spacing12);
  EdgeInsets get paddingAll16  => EdgeInsets.all(spacing16);
  EdgeInsets get paddingAll23  => EdgeInsets.all(spacing23);
  EdgeInsets get paddingAll24  => EdgeInsets.all(spacing24);

  EdgeInsets get paddingHorizontal4   => EdgeInsets.symmetric(horizontal: spacing4);
  EdgeInsets get paddingHorizontal8   => EdgeInsets.symmetric(horizontal: spacing8);
  EdgeInsets get paddingHorizontal10  => EdgeInsets.symmetric(horizontal: spacing10);
  EdgeInsets get paddingHorizontal12  => EdgeInsets.symmetric(horizontal: spacing12);
  EdgeInsets get paddingHorizontal16  => EdgeInsets.symmetric(horizontal: spacing16);
  EdgeInsets get paddingHorizontal23  => EdgeInsets.symmetric(horizontal: spacing23);
  EdgeInsets get paddingHorizontal24  => EdgeInsets.symmetric(horizontal: spacing24);

  EdgeInsets get paddingVertical4   => EdgeInsets.symmetric(vertical: spacing4);
  EdgeInsets get paddingVertical8   => EdgeInsets.symmetric(vertical: spacing8);
  EdgeInsets get paddingVertical10  => EdgeInsets.symmetric(vertical: spacing10);
  EdgeInsets get paddingVertical12  => EdgeInsets.symmetric(vertical: spacing12);
  EdgeInsets get paddingVertical16  => EdgeInsets.symmetric(vertical: spacing16);
  EdgeInsets get paddingVertical23  => EdgeInsets.symmetric(vertical: spacing23);
  EdgeInsets get paddingVertical24  => EdgeInsets.symmetric(vertical: spacing24);

  // Frequently used combos (keep the ones you actually use)
  EdgeInsets get paddingHorizontal24Vertical16 =>
      EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16);
  EdgeInsets get paddingLeft24Top12Right24Bottom16 =>
      EdgeInsets.fromLTRB(spacing24, spacing12, spacing24, spacing16);

  // One-side helpers
  EdgeInsets get paddingTop4    => EdgeInsets.only(top: spacing4);
  EdgeInsets get paddingBottom8 => EdgeInsets.only(bottom: spacing8);
  EdgeInsets get paddingLeft10  => EdgeInsets.only(left: spacing10);
  EdgeInsets get paddingRight12 => EdgeInsets.only(right: spacing12);

  // Gaps (SizedBox)
  SizedBox get gapHeight4   => SizedBox(height: spacing4);
  SizedBox get gapHeight8   => SizedBox(height: spacing8);
  SizedBox get gapHeight10  => SizedBox(height: spacing10);
  SizedBox get gapHeight12  => SizedBox(height: spacing12);
  SizedBox get gapHeight16  => SizedBox(height: spacing16);
  SizedBox get gapHeight23  => SizedBox(height: spacing23);
  SizedBox get gapHeight24  => SizedBox(height: spacing24);

  SizedBox get gapWidth4   => SizedBox(width: spacing4);
  SizedBox get gapWidth8   => SizedBox(width: spacing8);
  SizedBox get gapWidth10  => SizedBox(width: spacing10);
  SizedBox get gapWidth12  => SizedBox(width: spacing12);
  SizedBox get gapWidth16  => SizedBox(width: spacing16);
  SizedBox get gapWidth23  => SizedBox(width: spacing23);
  SizedBox get gapWidth24  => SizedBox(width: spacing24);

  const SpacingTokens({
    required this.spacing4,
    required this.spacing8,
    required this.spacing10,
    required this.spacing12,
    required this.spacing16,
    required this.spacing23,
    required this.spacing24,
  });

  @override
  SpacingTokens copyWith({
    double? spacing4,
    double? spacing8,
    double? spacing10,
    double? spacing12,
    double? spacing16,
    double? spacing23,
    double? spacing24,
  }) {
    return SpacingTokens(
      spacing4: spacing4 ?? this.spacing4,
      spacing8: spacing8 ?? this.spacing8,
      spacing10: spacing10 ?? this.spacing10,
      spacing12: spacing12 ?? this.spacing12,
      spacing16: spacing16 ?? this.spacing16,
      spacing23: spacing23 ?? this.spacing23,
      spacing24: spacing24 ?? this.spacing24,
    );
  }

  @override
  SpacingTokens lerp(ThemeExtension<SpacingTokens>? other, double t) {
    if (other is! SpacingTokens) {
      return this;
    }
    double l(double a, double b) => a + (b - a) * t;
    return SpacingTokens(
      spacing4:   l(spacing4,  other.spacing4),
      spacing8:  l(spacing8,  other.spacing8),
      spacing10: l(spacing10, other.spacing10),
      spacing12:  l(spacing12, other.spacing12),
      spacing16:  l(spacing16, other.spacing16),
      spacing23:  l(spacing23, other.spacing23),
      spacing24:  l(spacing24, other.spacing24),
    );
  }
}

// Defaults equivalent to your AppSpacing values (mobile)
const mobileSpacingTokens = SpacingTokens(
  spacing4: 4,
  spacing8: 8,
  spacing10: 10,
  spacing12: 12,
  spacing16: 16,
  spacing23: 23,
  spacing24: 24,
);
