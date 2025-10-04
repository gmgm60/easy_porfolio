
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class GetThemeMode {
  final ThemeRepository repository;

  GetThemeMode(this.repository);

  Future<ThemeMode> call() {
    return repository.getThemeMode();
  }
}
