import 'dart:developer' as developer;

class AppLogger {
  static void log(String message) {
    developer.log(message, name: 'AppLog');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: 'AppError', error: error, stackTrace: stackTrace);
  }
}
