import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/workout_repo/models/workout_model.dart';
import '../../../domain/workout_repo/workout_repo_interface.dart';

part 'add_program_bloc.freezed.dart';

class AddProgramBloc extends Bloc<AddProgramEvent, AddProgramState> {
  late final IWorkoutRepo _workoutRepo;

  AddProgramBloc({required IWorkoutRepo workoutRepo})
      : super(const _Initial()) {
    _workoutRepo = workoutRepo;
    on<AddProgramEvent>((
      AddProgramEvent event,
      Emitter<AddProgramState> emit,
    ) async {
      await event.map<Future<void>>(
        addWorkout: (_AddWorkout event) => _addWorkout(event, emit),
        initialization: (_Initialization event) => _initialization(event, emit),
      );
    });
  }

  Future<void> _initialization(
    _Initialization event,
    Emitter<AddProgramState> emitter,
  ) {
    final WorkoutModel? workoutModel = event.workoutModel;
    if (workoutModel != null) {
      emitter(AddProgramState.openWorkout(workoutModel: workoutModel));
    } else {
      emitter(const AddProgramState.createWorkout());
    }

    return Future<void>.value(null);
  }

  Future<void> _addWorkout(
    _AddWorkout event,
    Emitter<AddProgramState> emitter,
  ) async {
    emitter(state.copyWith(isLoading: true));
    try {
      final WorkoutModel workoutModel = await _workoutRepo.addProgram(
        name: event.name,
        description: event.description,
      );
      emitter(AddProgramState.openWorkout(
        workoutModel: workoutModel,
      ));
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}

@freezed
class AddProgramEvent with _$AddProgramEvent {
  const factory AddProgramEvent.addWorkout({
    required String name,
    String? description,
  }) = _AddWorkout;
  const factory AddProgramEvent.initialization({
    WorkoutModel? workoutModel,
  }) = _Initialization;
}

@freezed
class AddProgramState with _$AddProgramState {
  const factory AddProgramState.initial({
    @Default(true) bool isLoading,
  }) = _Initial;
  const factory AddProgramState.createWorkout({
    @Default(false) bool isLoading,
  }) = _CreateWorkout;
  const factory AddProgramState.openWorkout({
    @Default(false) bool isLoading,
    required WorkoutModel workoutModel,
  }) = _OpenWorkout;
}
