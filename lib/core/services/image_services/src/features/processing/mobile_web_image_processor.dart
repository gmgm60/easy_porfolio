import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart' as pkg_compress;
import '../../core/logging/image_logger.dart';
import '../../core/models/picked_image_model.dart';
import 'compress_options.dart';
import 'image_processor.dart';

/// Web + Mobile:
/// - Compress via flutter_image_compress (supports web/mobile).
class MobileWebImageProcessor implements ImageProcessor {
  final ImageLogger _log;

  MobileWebImageProcessor({ImageLogger? logger})
    : _log = logger ?? const DebugImageLogger();

  @override
  Future<PickedImageModel> compress(
    PickedImageModel input, {
    CompressOptions? compress,
  }) async {
    _log.debug('Processing (web/mobile) started for ${input.name}');

    // No compression options → just return the original model as-is.
    if (compress == null) {
      _log.debug('No compression options provided. Skipping compression.');
      return input;
    }

    Uint8List? workingBytes = input.bytes;

    _log.debug(
      'Applying flutter_image_compress: '
      'q=${compress.quality}, '
      'minW=${compress.minWidth}, '
      'minH=${compress.minHeight}, '
      'fmt=${compress.format}',
    );

    final compressed = await _compressBytes(
      input: input,
      options: compress,
      initialBytes: workingBytes,
    );

    if (compressed == null) {
      _log.warning(
        'Compression failed or no input data. Returning original image.',
      );
      return input;
    }

    workingBytes = compressed;
    _log.info('Compression done. New size=${workingBytes.length}');

    return input.copyWith(bytes: workingBytes);
  }

  Future<Uint8List?> _compressBytes({
    required PickedImageModel input,
    required CompressOptions options,
    required Uint8List? initialBytes,
  }) async {
    final format = _toCompressFormat(options.format);
    final minWidth = options.minWidth ?? 0;
    final minHeight = options.minHeight ?? 0;

    // 1) Prefer file-based compression when possible (non-web + valid path).
    final hasFilePath = !kIsWeb && input.path != null;
    if (hasFilePath) {
      _log.debug('Compressing from file: ${input.path}');
      return pkg_compress.FlutterImageCompress.compressWithFile(
        input.path!,
        quality: options.quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: format,
      );
    }

    // 2) Fallback to in-memory bytes.
    final hasBytes = initialBytes != null;
    if (hasBytes) {
      _log.debug('Compressing from bytes');
      final result = await pkg_compress.FlutterImageCompress.compressWithList(
        initialBytes,
        quality: options.quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: format,
      );
      return Uint8List.fromList(result);
    }

    // 3) No usable input.
    _log.warning('No file path or in-memory bytes available for compression.');
    return null;
  }

  pkg_compress.CompressFormat _toCompressFormat(CompressFormat f) {
    switch (f) {
      case CompressFormat.jpeg:
        return pkg_compress.CompressFormat.jpeg;
      case CompressFormat.png:
        return pkg_compress.CompressFormat.png;
      case CompressFormat.webp:
        return pkg_compress.CompressFormat.webp;
    }
  }
}
