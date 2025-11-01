import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/core/theme/color_palettes.dart';

/// Clean resolver: enum -> concrete palette (polymorphism via interface).
ColorPalette resolvePalette(AppThemeType type) {
  final palettes = ColorPalette.all;

  return palettes.firstWhere(
    (palette) => palette.themeType == type,
    orElse: LightPalette.new,
  );
}
