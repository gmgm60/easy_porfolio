
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class SetThemeMode {
  final ThemeRepository repository;

  SetThemeMode(this.repository);

  Future<void> call(AppThemeType themeMode) {
    return repository.setThemeMode(themeMode);
  }
}
