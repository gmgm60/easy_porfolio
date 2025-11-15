import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class QuickActionButtonWidget extends StatelessWidget {
  const QuickActionButtonWidget({super.key,
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
    final totalWidth =getScreenSize(context).threshold;

    final width =
    fullWidth ? double.infinity : (totalWidth - 48) / 2; // rough layout

    final child = Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      foregroundDecoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22.dp(context), color: colors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: styles.bodyLargeTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
