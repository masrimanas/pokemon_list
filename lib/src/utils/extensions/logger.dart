import 'package:flutter/foundation.dart';

void logger(
  Object? message, {
  LoggerColor color = LoggerColor.orange,
  StackTrace? stackTrace,
}) {
  final messageToPrint = '\x1B[${color.code}$message\x1B[0m';

  debugPrint(
    '$messageToPrint ${stackTrace != null ? 'stacktrace: $stackTrace' : ''}',
  );
}

extension Logger on Object? {
  void log({LoggerColor color = LoggerColor.cyan}) {
    logger(this, color: color);
  }
}

// LoggerColor and its extension
enum LoggerColor {
  orange, //'93m',
  blue, //'34m',
  green, //'32m',
  red, //'31m',
  purple, //'35m',
  cyan, //'96m',
  brightBlue, //'94m',
}

extension LoggerColorExtension on LoggerColor {
  String get code {
    switch (this) {
      case LoggerColor.orange:
        return '93m';
      case LoggerColor.blue:
        return '34m';
      case LoggerColor.green:
        return '32m';
      case LoggerColor.red:
        return '31m';
      case LoggerColor.purple:
        return '35m';
      case LoggerColor.cyan:
        return '96m';
      case LoggerColor.brightBlue:
        return '94m';
    }
  }
}
