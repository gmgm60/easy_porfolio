import 'core/logging/image_logger.dart';
import 'features/caching/default_image_cache.dart';
import 'features/caching/image_cache.dart';
import 'features/picking/image_picker.dart';
import 'features/processing/image_processor.dart';

/// A unified client for accessing all image services.
/// 
/// This facade provides access to:
/// - [picker]: For selecting images from camera or gallery.
/// - [processor]: For compressing and processing images.
/// - [cache]: For storing and retrieving images.
class ImageServices {
  final ImagePicker picker;
  final ImageProcessor processor;
  final ImageCache cache;
  final ImageLogger logger;

  const ImageServices({
    required this.picker,
    required this.processor,
    required this.cache,
    this.logger = const DebugImageLogger(),
  });

  /// Creates a default instance with platform-specific implementations.
  factory ImageServices.createDefault({ImageLogger? logger}) {
    final log = logger ?? const DebugImageLogger();
    return ImageServices(
      picker: ImagePickerImpl.createDefault(logger: log),
      processor: ImageProcessorImpl.createDefault(logger: log),
      cache: DefaultImageCache(logger: log),
      logger: log,
    );
  }
}
