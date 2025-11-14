import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context).platform to check the OS, which is web-safe.
    final platform = Theme.of(context).platform;

    // For iOS, return the Cupertino-style activity indicator.
    if (platform == TargetPlatform.iOS) {
      return SizedBox(
        width: 22.dp(context),
        height: 22.dp(context),
        // Use CupertinoActivityIndicator for an iOS look and feel.
        child: const CupertinoActivityIndicator(),
      );
    }

    // For Android, web, and other platforms, return the Material-style indicator.
    return SizedBox(
      width: 22.dp(context),
      height: 22.dp(context),
      child: const CircularProgressIndicator(strokeWidth: 2.4),
    );
  }
}