import '../../core/logging/image_logger.dart';
import '../../core/models/picked_image_model.dart';
import '../../utils/platform_utils.dart';

import 'compress_options.dart';
import 'desktop_image_processor.dart';
import 'mobile_web_image_processor.dart';

abstract class ImageProcessor {
  /// Crop first (if options provided), then compress.
  Future<PickedImageModel> compress(
    PickedImageModel input, {
    CompressOptions? compress,
  });
}

class ImageProcessorImpl implements ImageProcessor {
  final ImageProcessor _delegate;

  ImageProcessorImpl._(this._delegate);

  factory ImageProcessorImpl.createDefault({ImageLogger? logger}) {
    final delegate = ImageServicePlatformUtils.isDesktop
        ? DesktopImageProcessor(logger: logger)
        : MobileWebImageProcessor(logger: logger);

    return ImageProcessorImpl._(delegate);
  }

  @override
  Future<PickedImageModel> compress(
    PickedImageModel input, {
    CompressOptions? compress,
  }) => _delegate.compress(input, compress: compress);
}
