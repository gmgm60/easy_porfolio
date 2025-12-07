import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/image_compress_service.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/mobile_image_compress.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/adaptive_image_picker.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';
import 'package:easy_porfolio/core/services/messaging_service/helper_message.dart';

/// Widget for picking and displaying multiple images.
/// Supports adding, displaying, and deleting individual images.
class MultiImagePickerWidget extends StatefulWidget {
  const MultiImagePickerWidget({
    super.key,
    required this.onImagesChanged,
    this.initialImages = const [],
    this.label = 'Images',
    this.maxImages,
    this.showDeleteButton = true,
  });

  /// Callback when images are added or removed.
  /// Returns a list of PickedImage with either URL or bytes.
  final Function(List<PickedImage> images) onImagesChanged;

  /// Initial images to display (URLs or data URLs).
  final List<String> initialImages;

  /// Label for the image picker section.
  final String label;

  /// Maximum number of images allowed (null for unlimited).
  final int? maxImages;

  /// Whether to show delete buttons on images.
  final bool showDeleteButton;

  @override
  State<MultiImagePickerWidget> createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  final ImagePickerServices _imageServices = AdaptiveImagePicker();
  final ImageCompressService _compress = ImageCompress();
  final List<PickedImage> _images = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing images
    _images.addAll(widget.initialImages.map((url) => PickedImage.fromUrl(url)));
    // Notify parent of initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_images.isNotEmpty) {
        widget.onImagesChanged(_images);
      }
    });
  }

  Future<void> _pickImages() async {
    if (widget.maxImages != null && _images.length >= widget.maxImages!) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final pickedImages = await _imageServices.pickMultiple();

      if (pickedImages.isEmpty) {
        return;
      }

      for (final pickedImage in pickedImages) {
        if (widget.maxImages != null && _images.length >= widget.maxImages!) {
          break;
        }

        // Compress the image
        final compressed = await _compress.compress(pickedImage);

        setState(() {
          _images.add(compressed);
        });
      }

      _notifyChange();
    } catch (e) {
      if (mounted) {
        ToastMessage.failed(message: 'Error picking images: $e', ctx: context);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    _notifyChange();
  }

  void _notifyChange() {
    widget.onImagesChanged(_images);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacingTokens;
    final radius = context.radiusTokens;
    final textStyles = context.textStyles;

    final canAddMore =
        widget.maxImages == null || _images.length < widget.maxImages!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label, style: textStyles.bodyMediumTextStyle),
            if (widget.maxImages != null)
              Text(
                '${_images.length}/${widget.maxImages}',
                style: textStyles.bodySmallTextStyle.copyWith(
                  color: colors.textMuted,
                ),
              ),
          ],
        ),
        SizedBox(height: spacing.sm),

        // Images Grid
        if (_images.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: spacing.sm,
              mainAxisSpacing: spacing.sm,
              childAspectRatio: 1.0,
            ),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return _buildImageItem(context, index, colors, radius, spacing);
            },
          ),

        SizedBox(height: spacing.sm),

        // Add Image Button
        if (canAddMore)
          FadeScaleAnimation(
            child: GestureDetector(
              onTap: _isLoading ? null : _pickImages,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: radius.all12,
                  border: Border.all(
                    color: colors.textMuted.withValues(alpha: 0.3),
                  ),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: colors.primary),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: spacing.lg,
                            color: colors.textMuted,
                          ),
                          SizedBox(height: spacing.xs),
                          Text(
                            'Add Images',
                            style: textStyles.bodySmallTextStyle.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImageItem(
    BuildContext context,
    int index,
    dynamic colors,
    dynamic radius,
    dynamic spacing,
  ) {
    final image = _images[index];

    return Stack(
      children: [
        ClipRRect(
          borderRadius: radius.all12,
          child: image.bytes != null
              ? Image.memory(
                  image.bytes!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : image.path != null && image.path!.isNotEmpty
              ? Image.network(
                  image.path!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder(colors, radius, spacing);
                  },
                )
              : _buildPlaceholder(colors, radius, spacing),
        ),
        if (widget.showDeleteButton)
          Positioned(
            top: spacing.xs / 2,
            right: spacing.xs / 2,
            child: Material(
              color: colors.error,
              borderRadius: radius.all4,
              child: InkWell(
                onTap: () => _removeImage(index),
                borderRadius: radius.all4,
                child: Container(
                  padding: EdgeInsets.all(spacing.xs / 2),
                  child: Icon(
                    Icons.close,
                    size: spacing.md,
                    color: colors.onError,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder(dynamic colors, dynamic radius, dynamic spacing) {
    return Container(
      color: colors.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: spacing.lg,
          color: colors.textMuted,
        ),
      ),
    );
  }
}
