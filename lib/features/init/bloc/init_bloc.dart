import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'init_bloc.freezed.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitBloc() : super(const _Loading()) {
    on<InitEvent>((InitEvent event, Emitter<InitState> emit) async {
      await event.map(initialization: (event) => _initialization(event, emit));
    });
    add(const InitEvent.initialization());
  }

  _initialization(_Initialization event, Emitter<InitState> emit) {
    WidgetsFlutterBinding.ensureInitialized().allowFirstFrame();
    emit(const InitState.loaded());
  }
}

@freezed
class InitEvent with _$InitEvent {
  const factory InitEvent.initialization() = _Initialization;
}

@freezed
class InitState with _$InitState {
  const factory InitState.loading() = _Loading;
  const factory InitState.loaded() = _Loaded;
}
