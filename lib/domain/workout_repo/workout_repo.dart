import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';
import 'package:gym_helper/domain/workout_repo/workout_repo_interface.dart';
import 'package:uuid/uuid.dart';

import '../../data/external_storage/external_storage_interface.dart';

import '../auth_repo/i_auth_repo.dart';

class WorkoutRepo implements IWorkoutRepo {
  late final IExternalStorage _externalStorage;
  late final IAuthRepo _iAuthRepo;

  WorkoutRepo({
    required IExternalStorage externalStorage,
    required IAuthRepo iAuthRepo,
  }) {
    _externalStorage = externalStorage;
    _iAuthRepo = iAuthRepo;
  }
  @override
  Future<void> addWorkout({required String name, String? description}) async {
    try {
      const uuid = Uuid();

      final workoutModel = WorkoutModel(
        id: uuid.v4(),
        name: name,
        description: description,
      );
      final currentUser = _iAuthRepo.currentUser;
      if (currentUser != null) {
        await _externalStorage.addWorkout(workoutModel, currentUser);
      }
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}
