import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/theme/presentation/providers/theme_provider.dart';

extension ThemeModeExtension on WidgetRef {
  bool get isDarkTheme => watch(themeProvider) == ThemeMode.dark;
}
