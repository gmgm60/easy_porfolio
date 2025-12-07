import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/image_picker_placeholder_widget.dart';
import 'package:flutter/material.dart';

/// Widget that displays an image preview from either network or memory.
/// Handles loading states and error cases gracefully.
class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({super.key, required this.image});

  final PickedImage image;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    // Display from bytes if available (newly picked image)
    if (image.bytes != null) {
      return Image.memory(
        image.bytes!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const ImagePickerPlaceholderWidget();
        },
      );
    }

    // Display from URL if path is available (existing image)
    if (image.path != null) {
      return Image.network(
        image.path!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const ImagePickerPlaceholderWidget();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        },
      );
    }

    // Fallback to placeholder if no valid image data
    return const ImagePickerPlaceholderWidget();
  }
}
