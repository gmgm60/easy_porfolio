import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<AppThemeType> getThemeMode();
  Future<void> setThemeMode(AppThemeType themeMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  static const String cachedThemeMode = 'CACHED_THEME_MODE';

  @override
  Future<AppThemeType> getThemeMode() async {
    final themeModeString = sharedPreferences.getString(cachedThemeMode);
    if (themeModeString == null) {
      return AppThemeType.system;
    }
    return AppThemeType.values.firstWhere(
      (element) => element.toString() == themeModeString,
      orElse: () => AppThemeType.system,
    );
  }

  @override
  Future<void> setThemeMode(AppThemeType themeMode) {
    return sharedPreferences.setString(
      cachedThemeMode,
      themeMode.toString(),
    );
  }
}
