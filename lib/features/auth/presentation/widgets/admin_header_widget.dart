import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

/// Page header
class AdminHeaderWidget extends StatelessWidget {
  const AdminHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyles;

    return Column(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Admin Panel",
          style: textStyle.headlineMediumTextStyle,
        ),
         Text(
          "Sign in to manage your portfolio.",
          style: textStyle.labelSmallTextStyle,
        ),
      ],
    );
  }
}
