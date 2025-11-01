import 'package:easy_porfolio/core/theme/system_bars_extension.dart';
import 'package:easy_porfolio/core/theme/ui_overlay_style.dart';
import 'package:easy_porfolio/core/widgets/adaptive_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/core/navigation/app_router.dart';
import 'package:easy_porfolio/core/theme/app_theme.dart';
import 'package:easy_porfolio/features/theme/data/datasources/theme_local_datasource.dart';
import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        themeLocalDataSourceProvider.overrideWithValue(
          ThemeLocalDataSourceImpl(sharedPreferences: sharedPreferences),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final materialTheme = AppTheme.ofMaterial(context, ref);
    final cupertinoTheme = AppTheme.ofCupertino(materialTheme);

    return AdaptiveApp(
      title: 'Easy Portfolio',
      router: appRouter,
       materialTheme: materialTheme,
      cupertinoTheme: cupertinoTheme,
      overlay: SystemUiOverlayStyle.dark,
    );
  }
}
