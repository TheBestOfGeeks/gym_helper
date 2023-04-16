import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../common/error_handler.dart';
import 'injection_container.dart';

final Logger logger = Logger();

class StateObserver extends BlocObserver {
  final ErrorHandler _errorHandler = getIt();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    logger.d('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _errorHandler.handleError(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
