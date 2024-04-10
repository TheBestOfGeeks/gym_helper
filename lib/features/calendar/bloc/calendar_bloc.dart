import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/workout_repo/models/workout_model.dart';
import '../../../domain/workout_repo/workout_repo_interface.dart';

part 'calendar_bloc.freezed.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final IWorkoutRepo workoutRepo;

  CalendarBloc({required this.workoutRepo}) : super(const _Initial()) {
    on<CalendarEvent>((event, emit) async {
      event.map(
        addEvent: (event) async => await _addEvent(event, emit),
      );
    });
  }
  Future<void> _addEvent(_AddEvent event, Emitter<CalendarState> emit) async {
    event.workoutModel;
  }
}

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.addEvent(WorkoutModel workoutModel) = _AddEvent;
}

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = _Initial;
}
