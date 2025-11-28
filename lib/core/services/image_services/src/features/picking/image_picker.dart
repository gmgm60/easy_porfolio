import 'package:flutter/widgets.dart';
import 'package:easy_porfolio/core/services/image_services/src/widgets/dialogs/adaptive_image_dialog.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/logging/image_logger.dart';
import 'package:easy_porfolio/core/services/image_services/src/core/models/picked_image_model.dart';
 import 'package:easy_porfolio/core/services/image_services/src/features/picking/adaptive_image_picker.dart';

export '../../widgets/dialogs/adaptive_image_dialog.dart' show ImagePickSource;

abstract class ImagePicker {
  Future<PickedImageModel?> pickImage(BuildContext context);
  Future<List<PickedImageModel>> pickMultiImage(BuildContext context);
}

abstract class ImagePickerDelegate {
  Future<PickedImageModel?> pickSingle({required ImagePickSource source});
  Future<List<PickedImageModel>> pickMultiple({required ImagePickSource source});
}

class ImagePickerImpl implements ImagePicker {
  final ImagePickerDelegate _delegate;
  final AdaptiveImageDialog _dialog;
  final ImageLogger _log;

  ImagePickerImpl({
    ImagePickerDelegate? delegate,
    AdaptiveImageDialog? dialog,
    ImageLogger? logger,
  })  : _delegate = delegate ?? AdaptiveImagePicker(),
        _dialog = dialog ?? const AdaptiveImageDialog(),
        _log = logger ?? const DebugImageLogger();

  factory ImagePickerImpl.createDefault({ImageLogger? logger}) {
    final delegate =  AdaptiveImagePicker(logger: logger);
    return ImagePickerImpl(delegate: delegate, logger: logger);
  }

  @override
  Future<PickedImageModel?> pickImage(BuildContext context) async {
    _log.debug('pickImage() called');
    final source = await _resolveSourceIfNeeded(context);
    if (source == null) {
      _log.info('pickImage() canceled by user');
      return null;
    }
    final img = await _delegate.pickSingle(source: source);
    _log.info('pickImage() finished: ${img?.name}');
    return img;
  }

  @override
  Future<List<PickedImageModel>> pickMultiImage(BuildContext context) async {
    _log.debug('pickMultiImage() called');
    final source = await _resolveSourceIfNeeded(context);
    if (source == null) {
      _log.info('pickMultiImage() canceled by user');
      return <PickedImageModel>[];
    }
    final imgs = await _delegate.pickMultiple(source: source);
    _log.info('pickMultiImage() finished: count=${imgs.length}');
    return imgs;
  }

  Future<ImagePickSource?> _resolveSourceIfNeeded(BuildContext context) async {
    _log.debug('Adaptive  platform: showing source chooser');
    return _dialog.showSourceChooser(context);
  }
}
