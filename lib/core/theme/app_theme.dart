import 'package:easy_porfolio/core/extenstion/theme_extension.dart';
import 'package:easy_porfolio/core/theme/color_palette_resolver.dart';
import 'package:easy_porfolio/core/theme/components_theme.dart';
import 'package:easy_porfolio/core/theme/font_config.dart';
import 'package:easy_porfolio/core/theme/radius_scale_extension.dart';
import 'package:easy_porfolio/core/theme/radius_tokens.dart';
import 'package:easy_porfolio/core/theme/spacing_scale_extension.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:easy_porfolio/core/theme/system_bars_extension.dart';
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:easy_porfolio/core/theme/typography_scale_extension.dart';
import 'package:easy_porfolio/core/theme/ui_overlay_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  const AppTheme._();

  /// Build the app's Material [ThemeData] from the current [BuildContext].
  static ThemeData ofMaterial(BuildContext context, WidgetRef ref) {
    // ---- Settings ----------------------------------------------------------
    final theme = ref.currentTheme;

    // ---- Tokens ------------------------------------------------------------
    final palette = resolvePalette(theme);
    final bars = systemUiOverlayFor(palette);
    final typographyTokens = const TypographyScale(
      mobile: mobileTypography, tablet: tabletTypography, desktop: desktopTypography,
    );
    // ---- Base Material-3 Typography seed ----------------------------------
    final brightness = palette.brightness;
    final textTheme = buildGoogleTextTheme('Poppins', brightness: brightness);

    // ---- Base ThemeData ----------------------------------------------------
    final ThemeData base = ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.colors.primary,
        brightness: brightness,
      ),
      textTheme: textTheme,
      // ensure non-TextTheme widgets also use the family
      scaffoldBackgroundColor: palette.colors.surfaceVariant,
      // register your ThemeExtensions
      extensions: <ThemeExtension<dynamic>>[
        palette.colors,
        // SystemBars(bars),
        typographyTokens,
        const SpacingScale(
          mobile: mobileSpacingTokens,
          tablet: tabletSpacingTokens,
          desktop: desktopSpacingTokens,
        ),
        const RadiusScale(
          mobile: mobileRadiusTokens,
          tablet: tabletRadiusTokens,
          desktop: desktopRadiusTokens,
        ),
      ],
    );

    // ---- Apply component sub-themes (buttons, inputs, chips, etc.) --------
    final ThemeData themed = applyComponentThemes(
      base,
      palette.colors,
      typographyTokens.resolve(context),
      context,
    );

    return themed;
  }

  /// Build a Cupertino theme that *follows* the Material theme.
  static CupertinoThemeData ofCupertino(ThemeData materialTheme) {
    return MaterialBasedCupertinoThemeData(materialTheme: materialTheme);
  }
}
