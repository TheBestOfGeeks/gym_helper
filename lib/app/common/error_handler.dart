import '../settings/state_observer.dart';

class ErrorHandler {
  handleError(Object error, StackTrace stackTrace) {
    logger.d('Произошла ошибка ', error, stackTrace);
  }
}
