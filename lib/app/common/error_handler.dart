import 'package:injectable/injectable.dart';

import '../settings/state_observer.dart';

@injectable
class ErrorHandler {
  handleError(Object error, StackTrace stackTrace) {
    logger.d('Произошла ошибка ', error, stackTrace);
  }
}
