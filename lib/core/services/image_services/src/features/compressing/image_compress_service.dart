import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/compress_options.dart';

abstract class ImageCompressService {
  /// Crop first (if options provided), then compress.
  Future<PickedImage> compress(PickedImage input, {CompressOptions? compress  });
}
