import 'package:gym_helper/domain/workout_repo/models/exercise_model.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? date;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<ExerciseModel>? exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.exercises,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      date: map['date'] as DateTime?,
      startTime: map['startTime'] as DateTime?,
      endTime: map['endTime'] as DateTime?,
    );
  }
}
