import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Signature for a function that returns the desired system UI overlay.
typedef OverlayBuilder = SystemUiOverlayStyle Function(BuildContext context);

/// A thin shell that renders either MaterialApp.router or CupertinoApp.router,
/// keeping platform-specific concerns separate without duplicating your app code.
///
/// You typically provide:
/// - [title], [router],
/// - [materialTheme] from AppTheme.ofMaterial(context)
/// - [cupertinoTheme] from AppTheme.ofCupertino(materialTheme)
/// - [overlayBuilder] from your systemUiOverlayForScaffold(context)
class AdaptiveApp extends StatelessWidget {
  const AdaptiveApp({
    super.key,
    required this.title,
    required this.router,
   required this.themeMode,
    required this.materialTheme,
    required this.cupertinoTheme,
    required this.overlayBuilder,
    this.showDebugBanner = false,
  });

  final String title;
  final GoRouter router;
  final ThemeMode? themeMode;
  final ThemeData materialTheme;
  final CupertinoThemeData cupertinoTheme;

  final OverlayBuilder overlayBuilder;

  final bool showDebugBanner;

  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      // Pure Cupertino shell (router-based) with Material theming available
      return CupertinoApp.router(
        title: title,

        routerConfig: router,
        debugShowCheckedModeBanner: showDebugBanner,
        theme: cupertinoTheme,
            builder: (context, child) {
          final overlay = overlayBuilder(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: overlay,

            child: child!,
          );
        },
      );
    }

    // Pure Material shell (router-based) while still setting a CupertinoTheme
    return MaterialApp.router(
      title: title,
      routerConfig: router,
      debugShowCheckedModeBanner: showDebugBanner,
      theme: materialTheme,
    themeMode:themeMode ,
      builder: (context, child) {
        final overlay = overlayBuilder(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlay,

          child: child!,
        );
      },
    );
  }
}
