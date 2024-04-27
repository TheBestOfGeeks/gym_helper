import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';
import 'package:gym_helper/domain/workout_repo/workout_repo_interface.dart';
import 'package:uuid/uuid.dart';

import '../../data/external_storage/external_storage_interface.dart';
import '../auth_repo/i_auth_repo.dart';
import '../auth_repo/models/user_model.dart';

class WorkoutRepo implements IWorkoutRepo {
  late final IExternalStorage _externalStorage;
  late final IAuthRepo<User?> _iAuthRepo;

  WorkoutRepo({
    required IExternalStorage externalStorage,
    required IAuthRepo<User?> iAuthRepo,
  }) {
    _externalStorage = externalStorage;
    _iAuthRepo = iAuthRepo;
  }
  @override
  Future<WorkoutModel> addProgram({
    required String name,
    String? description,
  }) async {
    try {
      const Uuid uuid = Uuid();

      final WorkoutModel workoutModel = WorkoutModel(
        id: uuid.v4(),
        name: name,
        description: description,
      );
      final UserModel? currentUser = _iAuthRepo.currentUser;
      if (currentUser != null) {
        await _externalStorage.addWorkout(workoutModel, currentUser);

        return workoutModel;
      } else {
        await _iAuthRepo.singOut();
        throw Exception('currentUser is null');
      }
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<List<WorkoutModel>> getPrograms() async {
    final List<WorkoutModel> workoutModelsList = <WorkoutModel>[];
    final UserModel? currentUser = _iAuthRepo.currentUser;
    if (currentUser != null) {
      final List<Map<String, dynamic>> workouts =
          await _externalStorage.getWorkouts(currentUser);

      for (final Map<String, dynamic> element in workouts) {
        workoutModelsList.add(WorkoutModel.fromMap(element));
      }
    }

    return workoutModelsList;
  }
}
