import 'dart:typed_data';
import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/radius_tokens.dart';
import 'package:easy_porfolio/core/theme/spacing_tokens.dart';
import 'package:easy_porfolio/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:easy_porfolio/core/services/image_services/image_services.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';

/// Widget for picking and displaying an image.

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.initialImageUrl,
    this.label = 'Project Image',
  });

  final ImagePickedCallback onImagePicked;
  final String? initialImageUrl;
  final String label;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late final ImageServices _imageServices;

  String? _currentImageUrl;
  Uint8List? _currentImageBytes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageServices = ImageServices.createDefault();
    _currentImageUrl = widget.initialImageUrl;
  }

  Future<void> _pickImage() async {
    if (_isLoading) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final pickedImage = await _imageServices.picker.pickImage(context);
      if (pickedImage == null) {
        return;
      }

      final compressed = await _imageServices.processor.compress(pickedImage);
      final bytes = await compressed.readBytes();

      if (!mounted) {
        return;
      }

      setState(() {
        _currentImageBytes = bytes;
        _currentImageUrl = null; // We now rely on local bytes
      });

      // You can later swap '' with a proper URL if you upload to a server.
      widget.onImagePicked('', bytes);
    } catch (e) {
      if (!mounted) {
        return;
      }
      ToastMessage.failed(
        message: 'Error picking image: $e',
        ctx: context,
      );
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
        Text(
          widget.label,
          style: textStyles.bodyMediumTextStyle,
        ),
        SizedBox(height: spacing.sm),
        _ImagePickerField(
          isLoading: _isLoading,
          imageBytes: _currentImageBytes,
          imageUrl: _currentImageUrl,
          onTap: _pickImage,
        ),
      ],
    );
  }
}

/// Private widget: the clickable field that shows image / loader / placeholder.
class _ImagePickerField extends StatelessWidget {
  const _ImagePickerField({
    required this.isLoading,
    required this.imageBytes,
    required this.imageUrl,
    required this.onTap,
  });

  final bool isLoading;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
     final radius = context.radiusTokens;

    Widget child;
    if (isLoading) {
      child = Center(
        child: CircularProgressIndicator(
          color: colors.primary,
        ),
      );
    } else if (imageBytes != null) {
      child = _ImagePreview.memory(bytes: imageBytes!);
    } else if (imageUrl != null) {
      child = _ImagePreview.network(imageUrl: imageUrl!);
    } else {
      child = const _ImagePickerPlaceholder();
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
          border: Border.all(

            color: colors.textMuted.withValues(alpha: 0.3),
          ),
        ),
        child: ClipRRect(
          borderRadius: radius.all12,
          child: child,
        ),
      ),
    );
  }
}

/// Private widget: placeholder when there is no image.
class _ImagePickerPlaceholder extends StatelessWidget {
  const _ImagePickerPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final textStyles = context.textStyles;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
      ),
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

/// Private widget: image preview (network / memory) with a unified style.
class _ImagePreview extends StatelessWidget {
  const _ImagePreview._({
    this.imageUrl,
    this.bytes,
  }) : assert(imageUrl != null || bytes != null);

  factory _ImagePreview.network({required String imageUrl}) {
    return _ImagePreview._(imageUrl: imageUrl);
  }

  factory _ImagePreview.memory({required Uint8List bytes}) {
    return _ImagePreview._(bytes: bytes);
  }

  final String? imageUrl;
  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    if (bytes != null) {
      return Image.memory(
        bytes!,
        fit: BoxFit.cover,
      );
    }

    final colors = context.appColors;

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const _ImagePickerPlaceholder();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: colors.primary,
          ),
        );
      },
    );
  }
}
