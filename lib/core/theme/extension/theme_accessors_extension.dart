import 'package:flutter/material.dart';
import '../color_tokens.dart';
import '../radius_tokens.dart';
import '../spacing_tokens.dart';
import '../text_styles.dart';
import '../text_tokens.dart';

extension ThemeExtensionsAccessors on BuildContext {
  AppColors get appColors {
    final v = Theme.of(this).extension<AppColors>();
    assert(
      v != null,
      'AppColors not found. Make sure you add LightAppColors/DarkAppColors to ThemeData.extensions.',
    );
    return v!;
  }

  AppTypographyTokens get typographyTokens {
    final v = Theme.of(this).extension<AppTypographyTokens>();
    assert(
      v != null,
      'AppTypographyTokens not found. Add the active token set (mobile/tablet/desktop) to ThemeData.extensions.',
    );
    return v!;
  }

  SpacingTokens get spacingTokens {
    final v = Theme.of(this).extension<SpacingTokens>();
    assert(
      v != null,
      'SpacingTokens not found. Register mobile/tablet/desktop spacing tokens in ThemeData.extensions.',
    );
    return v!;
  }

  RadiusTokens get radiusTokens {
    final v = Theme.of(this).extension<RadiusTokens>();
    assert(
      v != null,
      'RadiusTokens not found. Register your radius tokens in ThemeData.extensions.',
    );
    return v!;
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
