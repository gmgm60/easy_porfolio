import 'package:file_picker/file_picker.dart';
import '../../core/logging/image_logger.dart';
import '../../core/models/picked_image_model.dart';
import '../../widgets/dialogs/adaptive_image_dialog.dart';
import 'image_picker.dart';

class DesktopImagePicker implements ImagePickerDelegate {
  final FilePicker _picker;
  final ImageLogger _log;

  DesktopImagePicker({
    FilePicker? picker,
    ImageLogger? logger,
  })  : _picker = picker ?? FilePicker.platform,
        _log = logger ?? const DebugImageLogger();

  @override
  Future<PickedImageModel?> pickSingle({required ImagePickSource source}) async {
    _log.debug('Desktop/Web pickSingle() opening file dialog...');
    final result = await _picker.pickFiles(
      type: FileType.image,
      withData: true,
     );

    final file = result?.files.single;
    if (file == null || file.bytes == null) {
      _log.info('Desktop/Web pickSingle() canceled.');
      return null;
    }

    final model = PickedImageModel(
      name: file.name,
      path: file.path,
      bytes: file.bytes,
    );

    _log.info('Desktop/Web pickSingle() got ${model.name}, size=${model.bytes?.length}');
    return model;
  }

  @override
  Future<List<PickedImageModel>> pickMultiple(
      {required ImagePickSource source}) async {
    _log.debug('Desktop/Web pickMultiple() opening file dialog...');
    final result = await _picker.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: true,
    );

    final files = result?.files;
    if (files == null || files.isEmpty) {
      _log.info('Desktop/Web pickMultiple() canceled / empty.');
      return <PickedImageModel>[];
    }

    final models = files
        .where((f) => f.bytes != null)
        .map((f) => PickedImageModel(
      name: f.name,
      path: f.path,
      bytes: f.bytes,
    ))
        .toList();

    _log.info('Desktop/Web pickMultiple() got count=${models.length}');
    return models;
  }
}
