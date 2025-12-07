import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/image_preview_widget.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/image_picker_placeholder_widget.dart';
import 'package:flutter/material.dart';

/// Clickable field widget that displays the current image state.
/// Shows either a loading indicator, image preview, or placeholder.
class ImagePickerFieldWidget extends StatelessWidget {
  const ImagePickerFieldWidget({
    super.key,
    required this.isLoading,
    required this.image,
    required this.onTap,
  });

  final bool isLoading;
  final PickedImage? image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final radius = context.radiusTokens;

    Widget content;
    if (isLoading) {
      content = Center(child: CircularProgressIndicator(color: colors.primary));
    } else if (image != null) {
      content = ImagePreviewWidget(image: image!);
    } else {
      content = const ImagePickerPlaceholderWidget();
    }

    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: radius.all12,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: radius.all12,
          border: Border.all(color: colors.textMuted.withValues(alpha: 0.3)),
        ),
        child: ClipRRect(borderRadius: radius.all12, child: content),
      ),
    );
  }
}
