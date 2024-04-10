import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/workout_repo/workout_repo_interface.dart';
part 'add_workout_bloc.freezed.dart';

class AddWorkoutBloc extends Bloc<AddWorkoutEvent, AddWorkoutState> {
  late final IWorkoutRepo _workoutRepo;

  AddWorkoutBloc({required IWorkoutRepo workoutRepo})
      : super(const _Initial()) {
    _workoutRepo = workoutRepo;
    on<AddWorkoutEvent>((event, emit) async {
      await event.map<Future<void>>(
        addWorkout: (event) async => await addWorkout(event),
      );
    });
  }

  Future<void> addWorkout(AddWorkoutEvent event) async {
    try {
      await _workoutRepo.addWorkout(name: event.name);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}

@freezed
class AddWorkoutEvent with _$AddWorkoutEvent {
  const factory AddWorkoutEvent.addWorkout({
    required String name,
    String? description,
  }) = _AddWorkout;
}

@freezed
class AddWorkoutState with _$AddWorkoutState {
  const factory AddWorkoutState.initial() = _Initial;
}
