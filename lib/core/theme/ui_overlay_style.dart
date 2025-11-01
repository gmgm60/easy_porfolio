import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle systemUiOverlayFor(ColorPalette color) {
  final colors = color.colors;
  // Pick dark icons on light backgrounds, light icons on dark backgrounds.
  final brightness = color.brightness;
  final useDarkIcons = brightness == Brightness.light;

  return SystemUiOverlayStyle(
    // ANDROID: paint bars to match your scaffold
    statusBarColor: colors.background,
    systemNavigationBarColor: colors.background,

    // Icon colors (Android) – dark on light, light on dark
    statusBarIconBrightness: useDarkIcons ? Brightness.dark : Brightness.light,
    systemNavigationBarIconBrightness: useDarkIcons
        ? Brightness.dark
        : Brightness.light,

    // iOS text color is controlled by brightness
    // (dark content for light backgrounds, light content for dark backgrounds)
    statusBarBrightness: useDarkIcons ? Brightness.light : Brightness.dark,
  );
}
