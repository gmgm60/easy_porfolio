import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


extension ThemeModeExtension on WidgetRef {
  bool get isDarkTheme => watch(themeProvider) == ThemeMode.dark;
}
