import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_helper/data/external_storage/external_storage_interface.dart';
import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';

import '../../app/common/constants.dart';
import '../../app/common/logger.dart';
import '../../domain/auth_repo/models/user_model.dart';

class FirestoreStorage implements IExternalStorage {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel currentUser) async {
    try {
      final CollectionReference<Map<String, dynamic>> usersCollection =
          db.collection(usersPath);
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
      final CollectionReference<Map<String, dynamic>> workoutsCollection = db
          .collection(usersPath)
          .doc(currentUser.uid)
          .collection(programsPath);
      await workoutsCollection
          .doc(workoutModel.id)
          .set(workoutModel.toMap(), SetOptions(merge: true));
      logger.d('Workout successfully added');
    } on Exception catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getWorkouts(
    UserModel currentUser,
  ) async {
    final CollectionReference<Map<String, dynamic>> workoutsCollection =
        db.collection(usersPath).doc(currentUser.uid).collection(programsPath);
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await workoutsCollection.get();

    return snapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data())
        .toList();
  }
}
