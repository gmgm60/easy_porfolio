import 'package:flutter/material.dart';
 import 'package:easy_porfolio/core/utils/platform_utils.dart';
import 'package:image_picker/image_picker.dart';

class AdaptiveImageDialog {
  const AdaptiveImageDialog();

  Future<ImageSource?> showSourceChooser(BuildContext context) async {
    if ( PlatformUtils.isDesktopOrWeb) {
      return ImageSource.gallery;
    }

     return _showAdaptive(context);
  }

  Future<ImageSource?> _showAdaptive(BuildContext context) {
    return showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text('Select image source'),
        content: const Text('Where do you want to get the image from?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(ImageSource.gallery),
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
