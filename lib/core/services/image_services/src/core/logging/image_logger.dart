import 'package:flutter/foundation.dart';

abstract class ImageLogger {
  void debug(String message);
  void info(String message);
  void warning(String message);
  void error(String message, [Object? error, StackTrace? st]);
}

/// Default lightweight logger using debugPrint.
class DebugImageLogger implements ImageLogger {
  final String tag;
  const DebugImageLogger({this.tag = 'ImageServices'});

  @override
  void debug(String message) => debugPrint('[$tag][DEBUG] $message');

  @override
  void info(String message) => debugPrint('[$tag][INFO]  $message');

  @override
  void warning(String message) => debugPrint('[$tag][WARN]  $message');

  @override
  void error(String message, [Object? error, StackTrace? st]) {
    debugPrint('[$tag][ERROR] $message');
    if (error != null) {
      debugPrint('[$tag][ERROR] error=$error');
    }
    if (st != null) {
      debugPrint('[$tag][ERROR] stack=$st');
    }
  }
}
