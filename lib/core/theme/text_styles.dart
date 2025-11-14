import 'package:easy_porfolio/core/theme/app_colors.dart';
 import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:flutter/material.dart';

class TextStyles {
  TextStyles({
    required this.colors,
    required this.tokens,
    required this.buildContext,
  });

  final AppColors colors;
  final AppTypographyTokens tokens;
  final BuildContext buildContext;

  // Body
  TextStyle get bodySmallTextStyle => TextStyle(
    color: colors.textSecondary,
    fontSize: tokens.bodySmall.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get bodyMediumTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.bodyMedium.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get bodyLargeTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.bodyLarge.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  // Titles
  TextStyle get titleSmallTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.titleSmall.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w600,
  );

  TextStyle get titleMediumTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.titleMedium.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w700,
  );

  TextStyle get titleLargeTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.titleLarge.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w700,
  );

  // Headlines / Display
  TextStyle get headlineSmallTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.headlineSmall.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w600,
  );

  TextStyle get headlineMediumTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.headlineMedium.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w700,
  );

  TextStyle get headlineLargeTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.headlineLarge.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w800,
  );

  TextStyle get displaySmallTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.displaySmall.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.bold,
  );

  TextStyle get displayMediumTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.displayMedium .sp(buildContext),
    height: tokens.lineHeight,
    fontWeight: FontWeight.bold,
  );

  TextStyle get displayLargeTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.displayLarge.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.bold,
  );

  // Labels / Buttons
  TextStyle get labelSmallTextStyle => TextStyle(
    color: colors.textSecondary,
    fontSize: tokens.labelSmall.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get labelMediumTextStyle => TextStyle(
    color: colors.textSecondary,
    fontSize: tokens.labelMedium.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get labelLargeTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.labelLarge.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get buttonTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.buttonText.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.normal,
  );

  // Navigation & Special
  TextStyle get navigationTitleTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.navigationTitle.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w600,
  );

  TextStyle get navigationLargeTitleTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.navigationLargeTitle.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.bold,
  );

  TextStyle get actionTextStyle => TextStyle(
    color: colors.primary,
    fontSize: tokens.actionText.sp(buildContext) ,
    height: tokens.lineHeight,
    fontWeight: FontWeight.w600,
  );

  TextStyle get pickerTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.pickerText.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get dateTimePickerTextStyle => TextStyle(
    color: colors.textPrimary,
    fontSize: tokens.dateTimePickerText.sp(buildContext) ,
    height: tokens.lineHeight,
  );

  TextStyle get captionTextStyle => TextStyle(
    color: colors.textSecondary,
    fontSize: tokens.caption.sp(buildContext) ,
    height: tokens.lineHeight,
  );
}


