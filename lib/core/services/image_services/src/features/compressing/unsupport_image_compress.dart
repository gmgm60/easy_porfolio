import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/compress_options.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/image_compress_service.dart';

class ImageCompress implements ImageCompressService {
  @override
  Future<PickedImage> compress(PickedImage input,
      {CompressOptions? compress = const CompressOptions()}) {
    // TODO: implement compress
    throw UnimplementedError();
  }
}