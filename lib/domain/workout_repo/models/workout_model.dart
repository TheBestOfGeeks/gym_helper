import 'package:gym_helper/domain/workout_repo/models/exercise_model.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String? description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final List<ExerciseModel>? exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.exercises,
  });
}
