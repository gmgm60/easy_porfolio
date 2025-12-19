import 'package:easy_porfolio/core/logging/app_logger.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/compress_options.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/compressing/image_compress_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompress implements ImageCompressService {
  final AppLogger _log;

  ImageCompress({AppLogger? logger}) : _log = logger ?? const DebugLogger();

  @override
  Future<PickedImage> compress(
      PickedImage input,
      { CompressOptions? compress = const CompressOptions()}
      ) async {
    if (input.path == null) {
      _log.warning(
        'Compression failed or no input data. Returning original image.',
      );
      return Future.value(input);
    }
    _log.debug(
      'Applying flutter_image_compress: '
          'q=${compress!.quality}, '
          'minW=${compress.minWidth}, '
          'minH=${compress.minHeight}, '
          'fmt=${compress.format}',
    );
    final compressed = await FlutterImageCompress.compressWithFile(
      input.path!,
      quality: compress.quality,
      minWidth: compress.minWidth ?? 0,
      minHeight: compress.minHeight ?? 0,
      format: compress.format,
    );
    _log.info('Compression done. New size=${compressed?.length}');
    return input.copyWith(bytes: compressed);
  }
}
