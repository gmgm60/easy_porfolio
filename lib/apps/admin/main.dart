import 'package:easy_porfolio/apps/main_shared.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_porfolio/core/navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final router = appRouter;

  await runSharedApp(
    sharedPreferences: sharedPreferences,
    router: router,
    title: 'Admin App',
  );
}