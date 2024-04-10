import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../common/error_handler.dart';
import 'service_locator.dart';

final Logger logger = Logger();

class StateObserver extends BlocObserver {
  final ErrorHandler _errorHandler = ServiceLocator.erroHandler;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    logger.d('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _errorHandler.handleError(error, stackTrace);
  }
}
