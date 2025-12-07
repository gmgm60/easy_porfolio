export 'unsupport_image_compress.dart'
    if (dart.library.html) 'web_image_compress.dart'
    if (dart.library.ffi) 'mobile_image_compress.dart';
