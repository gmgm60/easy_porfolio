
import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () {
        ref.read(themeProvider.notifier).toggleTheme();
      },
    );
  }
}
