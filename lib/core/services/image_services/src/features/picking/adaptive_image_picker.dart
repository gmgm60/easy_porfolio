 import 'package:easy_porfolio/core/services/image_services/src/core/logging/image_logger.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image_model.dart';
import 'package:easy_porfolio/core/services/image_services/src/features/picking/image_picker.dart';
import 'package:image_picker/image_picker.dart' as pkg;

class AdaptiveImagePicker implements ImagePickerDelegate {
  final pkg.ImagePicker _picker;
  final ImageLogger _log;

  AdaptiveImagePicker({pkg.ImagePicker? picker, ImageLogger? logger})
    : _picker = picker ?? pkg.ImagePicker(),
      _log = logger ?? const DebugImageLogger();

  @override
  Future<PickedImageModel?> pickSingle({
    required ImagePickSource source,
  }) async {
    final imgSource = source == ImagePickSource.camera
        ? pkg.ImageSource.camera
        : pkg.ImageSource.gallery;

    _log.debug('Adaptive pickSingle(source=$source) starting...');
    final pkg.XFile? file = await _picker.pickImage(source: imgSource);
    if (file == null) {
      _log.info('Adaptive pickSingle() user canceled.');
      return null;
    }

    final bytes = await file.readAsBytes();
    final model = PickedImageModel(
      name: file.name,
      path: file.path,
      bytes: bytes,
    );

    _log.info('Adaptive pickSingle() got ${model.name}');
    return model;
  }

  @override
  Future<List<PickedImageModel>> pickMultiple({
    required ImagePickSource source,
  }) async {
    _log.debug('Adaptive pickMultiple(source=$source) starting...');

    if (source == ImagePickSource.camera) {
      _log.warning(
        'Camera multi-pick not supported. Falling back to single pick.',
      );
      final single = await pickSingle(source: source);
      return single == null ? <PickedImageModel>[] : [single];
    }

    final files = await _picker.pickMultiImage();
    if (files.isEmpty) {
      _log.info('Adaptive pickMultiple() user canceled / no images.');
      return <PickedImageModel>[];
    }

    final results = <PickedImageModel>[];
    for (final f in files) {
      final bytes = await f.readAsBytes();
      results.add(PickedImageModel(name: f.name, path: f.path, bytes: bytes));
    }

    _log.info('Mobile pickMultiple() got count=${results.length}');
    return results;
  }
}
