import 'package:flutter/material.dart';

import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

class MetricCardWidget extends StatelessWidget {
  const MetricCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.changeLabel,
    required this.isPositive,
  });

  final String title;
  final String value;
  final String changeLabel;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    // Use your custom theme extensions for consistent styling
    final colors = context.appColors;
    final styles = context.textStyles;
    final radius = context.radiusTokens;

    // Determine the color for the change label from your theme colors
    final color = isPositive ? colors.textPrimary : colors.error;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
         color: colors.surface,
         borderRadius: radius.all16,
         border: Border.all(color: colors.textMuted.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
             style: styles.labelLargeTextStyle.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
             style: styles.headlineSmallTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            changeLabel,
             style: styles.bodySmallTextStyle.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}