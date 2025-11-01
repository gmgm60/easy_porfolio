
import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class GetThemeMode {
  final ThemeRepository repository;

  GetThemeMode(this.repository);

  Future<AppThemeType> call() {
    return repository.getThemeMode();
  }
}
