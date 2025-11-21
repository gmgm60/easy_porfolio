import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/features/theme/domain/usecases/get_theme.dart';
import 'package:easy_porfolio/features/theme/domain/usecases/set_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_porfolio/features/theme/domain/repositories/theme_repository.dart';
import 'package:easy_porfolio/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:easy_porfolio/features/theme/data/datasources/theme_local_datasource.dart';

/// Notifier instead of StateNotifier
///
class ThemeNotifier extends Notifier<AppThemeType> {
  late final GetThemeMode _getThemeMode;
  late final SetThemeMode _setThemeMode;

  @override
  AppThemeType build() {
    // Read dependencies here instead of using a constructor
    _getThemeMode = ref.read(getThemeModeProvider);
    _setThemeMode = ref.read(setThemeModeProvider);

    // Load the initial theme asynchronously after the first build
    _loadInitialTheme();

    // Initial value while loading the saved theme
    return AppThemeType.light;
  }

  /// Loads the saved theme from storage and updates the state.
  Future<void> _loadInitialTheme() async {
    final savedTheme = await _getThemeMode();
    state = savedTheme;
  }

  /// Toggles between light and dark themes and persists the change.
  Future<void> toggleTheme() async {
    final newThemeMode = state == AppThemeType.light
        ? AppThemeType.dark
        : AppThemeType.light;
    state = newThemeMode;
    await _setThemeMode(newThemeMode);
  }

  /// Sets a specific theme and persists it.
  Future<void> setTheme(AppThemeType themeMode) async {
    state = themeMode;
    await _setThemeMode(themeMode);
  }
}

/// The remaining providers stay the same (Provider is still fully supported)
final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>((ref) {
  throw UnimplementedError();
});

/// Provides the repository implementation for theme persistence.
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


/// NotifierProvider instead of StateNotifierProvider
final themeProvider =
NotifierProvider<ThemeNotifier, AppThemeType>(ThemeNotifier.new);