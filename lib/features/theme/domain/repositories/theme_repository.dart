import 'package:easy_porfolio/core/theme/app_theme_types.dart';

abstract class ThemeRepository {
  Future<AppThemeType> getThemeMode();
  Future<void> setThemeMode(AppThemeType themeMode);
}
