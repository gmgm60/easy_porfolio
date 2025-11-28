import 'dart:io';
import 'package:flutter/foundation.dart';

/// Centralized platform detection for image services.
class ImageServicePlatformUtils {
  const ImageServicePlatformUtils._();

  static bool get isWeb => kIsWeb;

  static bool get isMobile =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static bool get isDesktop =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  static bool get isDesktopOrWeb =>
      isWeb || isDesktop;
}
