import 'package:flutter/foundation.dart';

abstract class AppLogger {
  void debug(String message);
  void info(String message);
  void warning(String message);
  void error(String message, [Object? error, StackTrace? st]);
}

/// Default lightweight logger using debugPrint.
class DebugLogger implements AppLogger {
  final String tag;
  const DebugLogger({this.tag = 'AppLogger'});

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
