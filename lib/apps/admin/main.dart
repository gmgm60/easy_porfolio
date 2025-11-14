import 'package:easy_porfolio/apps/main_shared.dart';
import 'package:easy_porfolio/core/navigation/admin_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final router = adminRouter;

  await runSharedApp(
    sharedPreferences: sharedPreferences,
    router: router,
    title: 'Admin App',
  );
}