import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle systemUiOverlayForScaffold(BuildContext context) {
  final bg = Theme.of(context).scaffoldBackgroundColor;

  // Pick dark icons on light backgrounds, light icons on dark backgrounds.
  final bgBrightness = ThemeData.estimateBrightnessForColor(bg);
  final useDarkIcons = bgBrightness == Brightness.light;

  return SystemUiOverlayStyle(
    // ANDROID: paint bars to match your scaffold
    statusBarColor: bg,
    systemNavigationBarColor: bg,

    // Icon colors (Android) – dark on light, light on dark
    statusBarIconBrightness:
    useDarkIcons ? Brightness.dark : Brightness.light,
    systemNavigationBarIconBrightness:
    useDarkIcons ? Brightness.dark : Brightness.light,

    // iOS text color is controlled by brightness
    // (dark content for light backgrounds, light content for dark backgrounds)
    statusBarBrightness:
    useDarkIcons ? Brightness.light : Brightness.dark,
  );
}
