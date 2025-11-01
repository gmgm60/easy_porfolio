 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontKind { system, google }

@immutable
class FontConfig {
  final String family;
  final FontKind kind;

  const FontConfig._(this.family, this.kind);
  const FontConfig.system(String family) : this._(family, FontKind.system);
  const FontConfig.google(String family) : this._(family, FontKind.google);
}

TextTheme buildTextTheme({
  required FontConfig font,
  required Brightness brightness,
  TargetPlatform? platform,
}) {
  final m3 = Typography.material2021(platform: platform ?? defaultTargetPlatform);
  final base = brightness == Brightness.dark ? m3.white : m3.black;

  return switch (font.kind) {
    FontKind.google => GoogleFonts.getTextTheme(font.family, base),
    FontKind.system => base.apply(fontFamily: font.family),
  };
}

// Optional convenience helpers if you prefer one-liners at call sites:
TextTheme buildGoogleTextTheme(String family, {required Brightness brightness, TargetPlatform? platform}) =>
    buildTextTheme(font: FontConfig.google(family), brightness: brightness, platform: platform);

TextTheme buildSystemTextTheme(String family, {required Brightness brightness, TargetPlatform? platform}) =>
    buildTextTheme(font: FontConfig.system(family), brightness: brightness, platform: platform);
