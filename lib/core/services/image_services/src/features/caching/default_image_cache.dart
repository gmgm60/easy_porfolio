import 'dart:typed_data';
import 'package:easy_porfolio/core/services/image_services/src/core/logging/image_logger.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
 import 'package:easy_porfolio/core/services/image_services/src/features/caching/image_cache.dart';

class DefaultImageCache implements ImageCache {
  final CacheManager _cache;
  final ImageLogger _log;

  DefaultImageCache({
    CacheManager? cacheManager,
    ImageLogger? logger,
  })  : _cache = cacheManager ?? DefaultCacheManager(),
        _log = logger ?? const DebugImageLogger();

  @override
  Future<void> put(String key, PickedImageModel image) async {
    try {
      _log.debug('Cache put(key=$key, name=${image.name})');
      
      final bytes = image.bytes ?? await image.readBytes();
      
      await _cache.putFile(
        key,
        bytes,
        fileExtension: _extFromName(image.name),
      );
      _log.info('Cache put done for key=$key');
    } catch (e, stack) {
      _log.error('Cache put failed for key=$key', e, stack);
    }
  }

  @override
  Future<PickedImageModel?> get(String key) async {
    try {
      _log.debug('Cache get(key=$key)');
      final fileInfo = await _cache.getFileFromCache(key);
      if (fileInfo == null) {
        _log.info('Cache miss for key=$key');
        return null;
      }

      final Uint8List bytes = await fileInfo.file.readAsBytes();
      final name = fileInfo.file.path.split('/').last;

      final model = PickedImageModel(name: name, path: fileInfo.file.path, bytes: bytes);
      _log.info('Cache hit key=$key, size=${bytes.length}');
      return model;
    } catch (e, stack) {
      _log.error('Cache get failed for key=$key', e, stack);
      return null;
    }
  }

  @override
  Future<void> evict(String key) async {
    _log.debug('Cache evict(key=$key)');
    await _cache.removeFile(key);
  }

  @override
  Future<void> clear() async {
   _log.warning('Cache clear() called');
    await _cache.emptyCache();
  }

  String _extFromName(String name) {
    final idx = name.lastIndexOf('.');
    if (idx == -1) {
      return 'jpg';
    }
    return name.substring(idx + 1).toLowerCase();
  }
}
