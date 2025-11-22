import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
 import 'package:flutter/material.dart';

class QuickActionButtonWidget extends StatelessWidget {
  const QuickActionButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    this.fullWidth = false,
  });

  final IconData icon;
  final String label;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final styles = context.textStyles;
    final totalWidth = MediaQuery.sizeOf(context).width;

    final width = fullWidth ? totalWidth : (totalWidth - 42) / 2; // rough layout

    final child = Container(
      width: width,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),

        leading: Icon(icon, size: 22.dp(context), color: colors.primary),
        title: Text(
          label,
          style: styles.bodyMediumTextStyle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: child,
      ),
    );
  }
}
