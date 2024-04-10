import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_helper/data/external_storage/external_storage_interface.dart';
import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';

import '../../domain/auth_repo/models/user_model.dart';

const String usersPath = "users";
const String workoutsPath = "programs";

class FirestoreStorage implements IExternalStorage {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel currentUser) async {
    try {
      final usersCollection = db.collection(usersPath);
      await usersCollection
          .doc(currentUser.uid)
          .set(currentUser.toMap(), SetOptions(merge: true));
    } on Exception catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> addWorkout(
    WorkoutModel workoutModel,
    UserModel currentUser,
  ) async {
    try {
      final workoutsCollection = db
          .collection(usersPath)
          .doc(currentUser.uid)
          .collection(workoutsPath);
      await workoutsCollection
          .doc(workoutModel.id)
          .set(workoutModel.toMap(), SetOptions(merge: true));
    } on Exception catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}
