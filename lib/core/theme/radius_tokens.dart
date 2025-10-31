 import 'package:flutter/material.dart';

@immutable
class RadiusTokens extends ThemeExtension<RadiusTokens> {
  // Scalar radii (keep your exact set)
  final double radius4;
  final double radius8;
  final double radius10;
  final double radius12;
  final double radius16;
  final double radius23;
  final double radius24;

  // BorderRadius presets
  BorderRadius get all4   => BorderRadius.all(Radius.circular(radius4));
  BorderRadius get all8   => BorderRadius.all(Radius.circular(radius8));
  BorderRadius get all10  => BorderRadius.all(Radius.circular(radius10));
  BorderRadius get all12  => BorderRadius.all(Radius.circular(radius12));
  BorderRadius get all16  => BorderRadius.all(Radius.circular(radius16));
  BorderRadius get all23  => BorderRadius.all(Radius.circular(radius23));
  BorderRadius get all24  => BorderRadius.all(Radius.circular(radius24));

  // Vertical-only presets you used
  BorderRadius get top12    => const BorderRadius.vertical(top: Radius.circular(12));
  BorderRadius get bottom16 => const BorderRadius.vertical(bottom: Radius.circular(16));

  // Optional semantic aliases
  BorderRadius get small  => all8;
  BorderRadius get medium => all12;
  BorderRadius get large  => all16;
  BorderRadius get xLarge => all24;

  const RadiusTokens({
    required this.radius4,
    required this.radius8,
    required this.radius10,
    required this.radius12,
    required this.radius16,
    required this.radius23,
    required this.radius24,
  });

  @override
  RadiusTokens copyWith({
    double? radius4,
    double? radius8,
    double? radius10,
    double? radius12,
    double? radius16,
    double? radius23,
    double? radius24,
  }) {
    return RadiusTokens(
      radius4: radius4 ?? this.radius4,
      radius8: radius8 ?? this.radius8,
      radius10: radius10 ?? this.radius10,
      radius12: radius12 ?? this.radius12,
      radius16: radius16 ?? this.radius16,
      radius23: radius23 ?? this.radius23,
      radius24: radius24 ?? this.radius24,
    );
  }

  @override
  RadiusTokens lerp(ThemeExtension<RadiusTokens>? other, double t) {
    if (other is! RadiusTokens) {
      return this;
    }
    double l(double a, double b) => a + (b - a) * t;
    return RadiusTokens(
      radius4:  l(radius4,  other.radius4),
      radius8:  l(radius8,  other.radius8),
      radius10: l(radius10, other.radius10),
      radius12: l(radius12, other.radius12),
      radius16: l(radius16, other.radius16),
      radius23: l(radius23, other.radius23),
      radius24: l(radius24, other.radius24),
    );
  }
}

// Defaults equivalent to your AppRadius values
const mobileRadiusTokens = RadiusTokens(
  radius4: 4,
  radius8: 8,
  radius10: 10,
  radius12: 12,
  radius16: 16,
  radius23: 23,
  radius24: 24,
);
