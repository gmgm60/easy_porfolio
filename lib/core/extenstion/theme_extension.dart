import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';
 import 'package:flutter_riverpod/flutter_riverpod.dart';


extension ThemeModeExtension on WidgetRef {
  AppThemeType get currentTheme => watch(themeProvider)  ;
}
