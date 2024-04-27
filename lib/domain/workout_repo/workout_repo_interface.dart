import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';

abstract interface class IWorkoutRepo {
  Future<WorkoutModel> addProgram({
    required String name,
    String? description,
  });

  Future<List<WorkoutModel>> getPrograms();
}
