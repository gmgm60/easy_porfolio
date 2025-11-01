
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/features/theme/data/datasources/theme_local_datasource.dart';
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<AppThemeType> getThemeMode() {
    return localDataSource.getThemeMode();
  }

  @override
  Future<void> setThemeMode(AppThemeType themeMode) {
    return localDataSource.setThemeMode(themeMode);
  }
}
