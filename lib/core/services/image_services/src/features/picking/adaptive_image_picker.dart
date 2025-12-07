import 'package:easy_porfolio/core/logging/app_logger.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';

class AdaptiveImagePicker implements ImagePickerServices {
  final ImagePicker _picker;
  final AppLogger _log;

  AdaptiveImagePicker({ImagePicker? picker, AppLogger? logger})
    : _picker = picker ?? ImagePicker(),
      _log = logger ?? const DebugLogger();

  @override
  Future<PickedImage?> pickSingle({ImageSource imgSource = ImageSource.gallery}) async {
    final XFile? file = await _picker.pickImage(source: imgSource);
    if (file == null) {
      _log.info('Adaptive pickSingle() user canceled.');
      return null;
    }

    final bytes = await file.readAsBytes();
    final model = PickedImage(name: file.name, path: file.path, bytes: bytes);

    _log.info('Adaptive pickSingle() got ${model.name}');
    return model;
  }

  @override
  Future<List<PickedImage>> pickMultiple({
    ImageSource imgSource = ImageSource.gallery,
  }) async {
    final files = await _picker.pickMultiImage();
    if (files.isEmpty) {
      _log.info('Adaptive pickMultiple() user canceled / no images.');
      return <PickedImage>[];
    }

    final results = <PickedImage>[];
    for (final f in files) {
      final bytes = await f.readAsBytes();
      results.add(PickedImage(name: f.name, path: f.path, bytes: bytes));
    }

    _log.info('Adaptive pickMultiple() got count=${results.length}');
    return results;
  }
}
