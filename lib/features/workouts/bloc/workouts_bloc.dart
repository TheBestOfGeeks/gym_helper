import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'workouts_bloc.freezed.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(const _Initial()) {
    on<WorkoutsEvent>((event, emit) {});
  }
}

@freezed
class WorkoutsEvent with _$WorkoutsEvent {
  const factory WorkoutsEvent.started() = _Started;
}

@freezed
class WorkoutsState with _$WorkoutsState {
  const factory WorkoutsState.initial() = _Initial;
}
