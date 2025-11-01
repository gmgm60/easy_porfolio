import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/color_tokens.dart';
import 'package:easy_porfolio/core/theme/radius_scale_extension.dart';
import 'package:easy_porfolio/core/theme/radius_tokens.dart';
import 'package:easy_porfolio/core/theme/spacing_scale_extension.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:easy_porfolio/core/theme/text_styles.dart';
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:easy_porfolio/core/theme/typography_scale_extension.dart';
import 'package:flutter/material.dart';

extension ThemeExtensionsAccessors on BuildContext {
  AppColors get appColors {
    final v = Theme.of(this).extension<AppColors>();
    assert(
      v != null,
      'AppColors not found. Make sure you add  AppColors to ThemeData.extensions.',
    );
    return v!;
  }

  AppTypographyTokens get typographyTokens {
    return Theme.of(this).tokensOf(this);
  }

  SpacingTokens get spacingTokens {
    return Theme.of(this).spacingOf(this);
  }

  RadiusTokens get radiusTokens {
    return Theme.of(this).radiusOf(this);
  }

  TextStyles get textStyles {
    final style = TextStyles(
      colors: appColors,
      buildContext: this,
      tokens: typographyTokens,
    );
    return style;
  }
}
