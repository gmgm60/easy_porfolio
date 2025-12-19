import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/features/projects/presentation/admin/widgets/image_picker_placeholder_widget.dart';
import 'package:flutter/material.dart';

/// Widget that displays an image preview from memory only.
class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({super.key, required this.image});

  final PickedImage image;

  Uint8List? _getImageBytes() {
    if (image.bytes != null) {
      return image.bytes;
    }
    if (image.path != null) {
      try {
        String base64String = image.path!;
        // Handle data URL format
        if (base64String.startsWith('data:image')) {
          final commaIndex = base64String.indexOf(',');
          if (commaIndex != -1) {
            base64String = base64String.substring(commaIndex + 1);
          }
        }
        return base64Decode(base64String);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _getImageBytes();
    if (bytes == null) {
      return const ImagePickerPlaceholderWidget();
    }

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const ImagePickerPlaceholderWidget();
      },
    );
  }
}
