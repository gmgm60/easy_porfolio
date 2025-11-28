import 'package:flutter/material.dart';
import '../../utils/platform_utils.dart';

enum ImagePickSource { camera, gallery }

class AdaptiveImageDialog {
  const AdaptiveImageDialog();

  Future<ImagePickSource?> showSourceChooser(BuildContext context) async {
    if (ImageServicePlatformUtils.isDesktopOrWeb) {
      return ImagePickSource.gallery;
    }

    // Use adaptive dialog for (ios,android)
    return _showAdaptive(context);
  }

  Future<ImagePickSource?> _showAdaptive(BuildContext context) {
    return showDialog<ImagePickSource>(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text('Select image source'),
        content: const Text('Where do you want to get the image from?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(ImagePickSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(ImagePickSource.gallery),
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
