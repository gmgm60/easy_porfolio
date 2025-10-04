
import 'package:easy_porfolio/features/theme/domain/usecases/get_theme.dart';
import 'package:easy_porfolio/features/theme/domain/usecases/set_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:easy_porfolio/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:easy_porfolio/features/theme/data/datasources/theme_local_datasource.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final GetThemeMode getThemeMode;
  final SetThemeMode setThemeMode;

  ThemeNotifier({required this.getThemeMode, required this.setThemeMode}) : super(ThemeMode.system) {
    _loadInitialTheme();
  }

  Future<void> _loadInitialTheme() async {
    state = await getThemeMode();
  }

  Future<void> toggleTheme() async {
    final newThemeMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newThemeMode;
    await setThemeMode(newThemeMode);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    await setThemeMode(themeMode);
  }
}

final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>((ref) {
  throw UnimplementedError();
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  final localDataSource = ref.watch(themeLocalDataSourceProvider);
  return ThemeRepositoryImpl(localDataSource: localDataSource);
});

final getThemeModeProvider = Provider<GetThemeMode>((ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return GetThemeMode(repository);
});

final setThemeModeProvider = Provider<SetThemeMode>((ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return SetThemeMode(repository);
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final getThemeMode = ref.watch(getThemeModeProvider);
  final setThemeMode = ref.watch(setThemeModeProvider);
  return ThemeNotifier(getThemeMode: getThemeMode, setThemeMode: setThemeMode);
});

