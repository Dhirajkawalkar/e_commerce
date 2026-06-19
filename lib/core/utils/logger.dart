/// A utility class for centralized logging.
/// 
/// This class provides methods to log information and errors to the console
/// using the standard 'dart:developer' library.
import 'dart:developer' as developer;

class AppLogger {
  /// Logs a general message.
  static void log(String message) {
    developer.log(message, name: 'AppLog');
  }

  /// Logs an error message with optional error object and stack trace.
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: 'AppError', error: error, stackTrace: stackTrace);
  }
}
