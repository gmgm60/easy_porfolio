
import 'package:easy_porfolio/core/theme/radius_tokens.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

@immutable
class RadiusScale extends ThemeExtension<RadiusScale> {
  final RadiusTokens mobile;
  final RadiusTokens tablet;
  final RadiusTokens desktop;

  const RadiusScale({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  RadiusTokens resolve(BuildContext context) {
    switch (getScreenSize(context)) {
      case ScreenSize.mobile:  return mobile;
      case ScreenSize.tablet:  return tablet;
      case ScreenSize.desktop: return desktop;
    }
  }

  @override
  RadiusScale copyWith({
    RadiusTokens? mobile,
    RadiusTokens? tablet,
    RadiusTokens? desktop,
  }) => RadiusScale(
    mobile:  mobile  ?? this.mobile,
    tablet:  tablet  ?? this.tablet,
    desktop: desktop ?? this.desktop,
  );

  @override
  RadiusScale lerp(ThemeExtension<RadiusScale>? other, double t) {
    if (other is! RadiusScale) {
      return this;
    }
    return RadiusScale(
      mobile:  mobile.lerp(other.mobile,  t),
      tablet:  tablet.lerp(other.tablet,  t),
      desktop: desktop.lerp(other.desktop, t),
    );
  }
}

extension RadiusTokensX on ThemeData {
  RadiusTokens radiusOf(BuildContext context) =>
      extension<RadiusScale>()!.resolve(context);
}
