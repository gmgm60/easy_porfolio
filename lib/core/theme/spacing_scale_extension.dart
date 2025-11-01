
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

@immutable
class SpacingScale extends ThemeExtension<SpacingScale> {
  final SpacingTokens mobile;
  final SpacingTokens tablet;
  final SpacingTokens desktop;

  const SpacingScale({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  SpacingTokens resolve(BuildContext context) {
    switch (getScreenSize(context)) {
      case ScreenSize.mobile:  return mobile;
      case ScreenSize.tablet:  return tablet;
      case ScreenSize.desktop: return desktop;
    }
  }

  @override
  SpacingScale copyWith({
    SpacingTokens? mobile,
    SpacingTokens? tablet,
    SpacingTokens? desktop,
  }) => SpacingScale(
    mobile:  mobile  ?? this.mobile,
    tablet:  tablet  ?? this.tablet,
    desktop: desktop ?? this.desktop,
  );

  @override
  SpacingScale lerp(ThemeExtension<SpacingScale>? other, double t) {
    if (other is! SpacingScale) {
      return this;
    }
    return SpacingScale(
      mobile:  mobile.lerp(other.mobile,  t),
      tablet:  tablet.lerp(other.tablet,  t),
      desktop: desktop.lerp(other.desktop, t),
    );
  }
}

extension SpacingTokensX on ThemeData {
  SpacingTokens spacingOf(BuildContext context) =>
      extension<SpacingScale>()!.resolve(context);
}
