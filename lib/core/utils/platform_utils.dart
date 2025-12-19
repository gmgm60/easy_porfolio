import 'dart:io';
import 'package:flutter/foundation.dart';

/// Centralized platform detection for image services.
class PlatformUtils {
  const PlatformUtils._();

  static bool get isWeb => kIsWeb;

  static bool get isMobile =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static bool get isDesktopOrWeb =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
}
