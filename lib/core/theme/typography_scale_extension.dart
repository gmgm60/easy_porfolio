// lib/theme/typography_scale_extension.dart
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:flutter/material.dart';


@immutable
class TypographyScale extends ThemeExtension<TypographyScale> {
  final AppTypographyTokens mobile;
  final AppTypographyTokens tablet;
  final AppTypographyTokens desktop;

  const TypographyScale({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  AppTypographyTokens resolve(BuildContext context) {
    switch (getScreenSize(context)) {
      case ScreenSize.mobile:  return mobile;
      case ScreenSize.tablet:  return tablet;
      case ScreenSize.desktop: return desktop;
    }
  }

  @override
  TypographyScale copyWith({
    AppTypographyTokens? mobile,
    AppTypographyTokens? tablet,
    AppTypographyTokens? desktop,
  }) => TypographyScale(
    mobile:  mobile  ?? this.mobile,
    tablet:  tablet  ?? this.tablet,
    desktop: desktop ?? this.desktop,
  );

  @override
  TypographyScale lerp(ThemeExtension<TypographyScale>? other, double t) {
    if (other is! TypographyScale) {
      return this;
    }
    return TypographyScale(
      mobile:  mobile.lerp(other.mobile,  t),
      tablet:  tablet.lerp(other.tablet,  t),
      desktop: desktop.lerp(other.desktop, t),
    );
  }
}

extension TypographyTokensX on ThemeData {
  AppTypographyTokens tokensOf(BuildContext context) =>
      extension<TypographyScale>()!.resolve(context);
}
