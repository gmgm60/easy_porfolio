import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

/// Error banner for descriptive messages
class ErrorBannerWidget extends StatelessWidget {
  const ErrorBannerWidget({super.key,required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final style = context.textStyles;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.onError,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.error.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20.dp(context), color: colors.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: style.bodySmallTextStyle.copyWith(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }
}