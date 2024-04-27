import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/real_time_updater/real_time_updater_interface.dart';
import '../../../domain/workout_repo/models/workout_model.dart';
import '../../../domain/workout_repo/workout_repo_interface.dart';

part 'programs_bloc.freezed.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  late final IWorkoutRepo _workoutRepo;
  late final IRealTimeUpdater<List<WorkoutModel>> _realTimeUpdater;
  late final StreamSubscription<List<WorkoutModel>> _subscription;

  ProgramsBloc({
    required IWorkoutRepo workoutRepo,
    required IRealTimeUpdater<List<WorkoutModel>> realTimeUpdater,
  }) : super(const _Initial()) {
    _workoutRepo = workoutRepo;
    _realTimeUpdater = realTimeUpdater;
    on<ProgramsEvent>((ProgramsEvent event, Emitter<ProgramsState> emit) async {
      await event.map<Future<void>>(
        initialization: (_Initialization event) => _onInitialization(emit),
        refresh: (_Refresh event) => _refresh(event, emit),
      );
    });
    _subscription =
        _realTimeUpdater.dataStream().listen((List<WorkoutModel> event) {
      add(ProgramsEvent.refresh(programs: event));
    });
  }

  Future<void> _onInitialization(Emitter<ProgramsState> emitter) async {
    final List<WorkoutModel> programs = await _workoutRepo.getPrograms();

    emitter(ProgramsState.loaded(programs: programs));
  }

  Future<void> _refresh(_Refresh event, Emitter<ProgramsState> emitter) {
    emitter(ProgramsState.loaded(programs: event.programs));

    return Future<void>(() => null);
  }

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}

@freezed
class ProgramsEvent with _$ProgramsEvent {
  const factory ProgramsEvent.initialization() = _Initialization;
  const factory ProgramsEvent.refresh({required List<WorkoutModel> programs}) =
      _Refresh;
}

@freezed
class ProgramsState with _$ProgramsState {
  const factory ProgramsState.initial() = _Initial;
  const factory ProgramsState.loaded({required List<WorkoutModel> programs}) =
      _Loaded;
}
