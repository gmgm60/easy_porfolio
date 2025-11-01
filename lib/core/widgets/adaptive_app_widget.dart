import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Signature for a function that returns the desired system UI overlay.

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
     required this.materialTheme,
    required this.cupertinoTheme,
    required this.overlay ,
    this.showDebugBanner = false,
  });

  final String title;
  final GoRouter router;
   final ThemeData materialTheme;
  final CupertinoThemeData cupertinoTheme;

  final SystemUiOverlayStyle overlay ;

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
       builder: (context, child) {
         return AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlay,

          child: child!,
        );
      },
    );
  }
}
