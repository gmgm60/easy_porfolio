import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

/// Placeholder widget displayed when no image is selected.
/// Shows an icon and text prompting the user to add an image.
class ImagePickerPlaceholderWidget extends StatelessWidget {
  const ImagePickerPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.surfaceVariant),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: spacing.lg * 2,
            color: colors.textMuted,
          ),
          SizedBox(height: spacing.xs),
          Text(
            'Tap to add image',
            style: textStyles.bodySmallTextStyle.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
