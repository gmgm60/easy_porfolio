
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image_model.dart';

abstract class ImageCache {
  Future<void> put(String key, PickedImageModel image);
  Future<PickedImageModel?> get(String key);
  Future<void> evict(String key);
  Future<void> clear();
}
