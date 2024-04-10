import '../settings/state_observer.dart';

class ErrorHandler {
  const ErrorHandler();
  void handleError(Object error, StackTrace stackTrace) {
    logger.e('Произошла ошибка ', error, stackTrace);
  }
}
