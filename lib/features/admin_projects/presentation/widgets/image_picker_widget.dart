import 'dart:convert';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/adaptive_image_picker.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/image_picker_service.dart';
import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/admin_projects/presentation/widgets/image_picker_field_widget.dart';
import 'package:flutter/material.dart';

/// Widget for picking and displaying a single image.
///
/// Handles image selection, compression, and state management.
/// Uses PickedImage model for type-safe image data handling.
class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.initialImageUrl,
    this.label = 'Project Image',
  });

  /// Callback invoked when an image is successfully picked and processed.
  /// Provides the PickedImage instance containing the image data.
  final void Function(PickedImage image) onImagePicked;

  /// Optional initial image URL to display.
  final String? initialImageUrl;

  /// Label text displayed above the image picker field.
  final String label;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePickerServices _picker = AdaptiveImagePicker();
  PickedImage? _currentImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeImage();
  }

  void _initializeImage() {
    if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      try {
        String base64String = widget.initialImageUrl!;
        // Handle data URL format
        if (base64String.startsWith('data:image')) {
          final commaIndex = base64String.indexOf(',');
          if (commaIndex != -1) {
            base64String = base64String.substring(commaIndex + 1);
          }
        }
        final bytes = base64Decode(base64String);
        _currentImage = PickedImage.fromBytes(bytes);
      } catch (_) {
        _currentImage = null;
      }
    }
  }

  Future<void> _pickImage() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final pickedImage = await _picker.pickSingle();
      if (pickedImage == null || !mounted) {
        return;
      }

      setState(() {
        _currentImage = pickedImage;
      });

      widget.onImagePicked(pickedImage);
    } catch (error) {
      if (mounted) {
        ToastMessage.failed(
          message: 'Error picking image: $error',
          ctx: context,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: textStyles.bodyMediumTextStyle),
        SizedBox(height: spacing.sm),
        ImagePickerFieldWidget(
          isLoading: _isLoading,
          image: _currentImage,
          onTap: _pickImage,
        ),
      ],
    );
  }
}
