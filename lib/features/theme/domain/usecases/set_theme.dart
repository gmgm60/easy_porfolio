
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class SetThemeMode {
  final ThemeRepository repository;

  SetThemeMode(this.repository);

  Future<void> call(ThemeMode themeMode) {
    return repository.setThemeMode(themeMode);
  }
}
