import 'package:easy_porfolio/core/extenstion/theme_extension.dart';
import 'package:easy_porfolio/core/theme/color_palettes.dart';
import 'package:easy_porfolio/core/theme/color_tokens.dart';
import 'package:easy_porfolio/core/theme/components_theme.dart';
import 'package:easy_porfolio/core/theme/radius_tokens.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'  ;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  /// Build the app's Material [ThemeData] from the current [BuildContext].
  static ThemeData ofMaterial(BuildContext context,WidgetRef ref) {
    // ---- Settings ----------------------------------------------------------
    final bool isDark = ref.isDarkTheme;

    // ---- Tokens ------------------------------------------------------------
    final AppColors colors = isDark ? darkAppColors : lightAppColors;
        final AppTypographyTokens tokens = mobileTypography;//_tokensFor(getScreenSize(context));
    final spacing = mobileSpacingTokens;
    final radii = mobileRadiusTokens;

    // ---- Base Material-3 Typography seed ----------------------------------
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    final Typography m3 = Typography.material2021(
      platform: defaultTargetPlatform,
    ); // M3 seed
    final TextTheme baseText = brightness == Brightness.dark
        ? m3.white
        : m3.black; // start point

    final TextTheme googleTextTheme =   GoogleFonts.poppinsTextTheme(
            baseText,
          ); // package shows TextTheme helpers

    final TextTheme seededText = googleTextTheme.apply(
      displayColor: colors.textPrimary,
      bodyColor: colors.textPrimary,
    );

    final String? fontFamily =  GoogleFonts.poppins().fontFamily;

    // ---- Base ThemeData ----------------------------------------------------
    final ThemeData base = ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
      ),
      textTheme: seededText,
      fontFamily: fontFamily,
      // ensure non-TextTheme widgets also use the family
      scaffoldBackgroundColor: colors.surfaceVariant,
      // register your ThemeExtensions
      extensions: <ThemeExtension<dynamic>>[colors, tokens, spacing, radii],
    );

    // ---- Apply component sub-themes (buttons, inputs, chips, etc.) --------
    final ThemeData themed = applyComponentThemes(
      base,
      colors,
      tokens,
      context,
    );

    return themed;
  }

  /// Build a Cupertino theme that *follows* the Material theme.
  static CupertinoThemeData ofCupertino(ThemeData materialTheme) {
    return MaterialBasedCupertinoThemeData(materialTheme: materialTheme);
  }

  // Map screen-size buckets to your typography token sets.
  static AppTypographyTokens _tokensFor(ScreenSize size) {
    switch (size) {
      case ScreenSize.desktop:
        return desktopTypography;
      case ScreenSize.tablet:
        return tabletTypography;

      case ScreenSize.mobile:
        return mobileTypography;
    }
  }
}
