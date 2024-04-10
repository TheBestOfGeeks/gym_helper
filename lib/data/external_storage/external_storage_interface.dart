import '../../domain/auth_repo/models/user_model.dart';
import '../../domain/workout_repo/models/workout_model.dart';

abstract interface class IExternalStorage {
  Future<void> addUser(UserModel currentUser);

  Future<void> addWorkout(
    WorkoutModel workoutModel,
    UserModel currentUser,
  );
}
