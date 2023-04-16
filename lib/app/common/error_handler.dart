import 'package:injectable/injectable.dart';

import '../settings/state_observer.dart';

@injectable
class ErrorHandler {
  Future<void> handleError(Object error, StackTrace stackTrace) async {
    logger.d('Произошла ошибка ', error, stackTrace);
  }
}
