import 'package:easy_porfolio/core/services/messaging_service/toast/src/toast_list_overlay.dart';
import 'package:easy_porfolio/core/services/messaging_service/toast/toast_model.dart';
import 'package:easy_porfolio/core/widgets/adaptive_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/core/theme/app_theme.dart';
import 'package:easy_porfolio/features/theme/data/datasources/theme_local_datasource.dart';
import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';

Future<void> runSharedApp({
  required SharedPreferences sharedPreferences,
  required GoRouter router,
  required String title,
}) async {
  runApp(
    ProviderScope(
      overrides: [
        themeLocalDataSourceProvider.overrideWithValue(
          ThemeLocalDataSourceImpl(sharedPreferences: sharedPreferences),
        ),
      ],
      // Pass the specific router to the MyApp widget
      child: MyApp(title: title, router: router),
    ),
  );
}

 class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.title, required this.router});

  final GoRouter router;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialTheme = AppTheme.ofMaterial(context, ref);
    final cupertinoTheme = AppTheme.ofCupertino(materialTheme);

    return ToastListOverlay<ToastModel>(
      // position:Alignment.topCenter ,
      itemBuilder: buildToastItem,
      child: AdaptiveApp(
        title: title,
        router: router,
        materialTheme: materialTheme,
        cupertinoTheme: cupertinoTheme,
      ),
    );
  }
}
