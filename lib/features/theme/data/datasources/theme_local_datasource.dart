
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  static const String cachedThemeMode = 'CACHED_THEME_MODE';

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeModeString = sharedPreferences.getString(cachedThemeMode);
    if (themeModeString == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values.firstWhere(
      (element) => element.toString() == themeModeString,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) {
    return sharedPreferences.setString(
      cachedThemeMode,
      themeMode.toString(),
    );
  }
}
