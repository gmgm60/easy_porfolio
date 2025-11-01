import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/core/theme/color_palettes.dart';

/// Clean resolver: enum -> concrete palette (polymorphism via interface).
ColorPalette resolvePalette(AppThemeType type) {
  switch (type) {
    case AppThemeType.light:
      return const LightPalette();
    case AppThemeType.dark:
      return const DarkPalette();

    case AppThemeType.system:
      return const LightPalette();
  }
}
