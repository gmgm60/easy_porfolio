import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import '../../core/logging/image_logger.dart';
import '../../core/models/picked_image_model.dart';
import 'compress_options.dart';
import 'image_processor.dart';

/// Desktop:
/// - Crop + compression manually via pure Dart `image`.
class DesktopImageProcessor implements ImageProcessor {
  final ImageLogger _log;

  DesktopImageProcessor({ImageLogger? logger})
    : _log = logger ?? const DebugImageLogger();

  @override
  Future<PickedImageModel> compress(
    PickedImageModel input, {
    CompressOptions? compress,
  }) async {
    _log.debug('Processing (desktop) started for ${input.name}');

    final bytes = input.bytes ?? await input.readBytes();
    
    try {
      final outBytes = await compute(
        _processImageInIsolate,
        _IsolateData(bytes, compress),
      );
      _log.info('Compression done. New size=${outBytes.length}');
      return input.copyWith(bytes: outBytes);
    } catch (e) {
      _log.error('Desktop compression failed', e);
      return input;
    }
  }

}

class _IsolateData {
  final Uint8List bytes;
  final CompressOptions? options;

  _IsolateData(this.bytes, this.options);
}

Uint8List _processImageInIsolate(_IsolateData data) {
  final decoded = img.decodeImage(data.bytes);
  if (decoded == null) {
    return data.bytes;
  }

  if (data.options != null) {
    return _encodeWithQuality(decoded, data.options!);
  } else {
    return Uint8List.fromList(img.encodePng(decoded));
  }
}

Uint8List _encodeWithQuality(img.Image image, CompressOptions options) {
  switch (options.format) {
    case CompressFormat.jpeg:
      return Uint8List.fromList(
        img.encodeJpg(image, quality: options.quality),
      );
    case CompressFormat.png:
      return Uint8List.fromList(img.encodePng(image));
    case CompressFormat.webp:
       throw UnsupportedError('WebP encoding is not supported on Desktop yet.');
  }
}
