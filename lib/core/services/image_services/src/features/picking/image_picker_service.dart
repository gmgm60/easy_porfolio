import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerServices {
  Future<PickedImage?> pickSingle({  ImageSource imgSource});

  Future<List<PickedImage>> pickMultiple({  ImageSource imgSource});
}
