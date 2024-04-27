import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_helper/app/common/constants.dart';
import 'package:gym_helper/domain/auth_repo/i_auth_repo.dart';
import 'package:gym_helper/domain/auth_repo/models/user_model.dart';
import 'package:gym_helper/domain/real_time_updater/real_time_updater_interface.dart';
import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';

class ListWorkoutModelUpdater implements IRealTimeUpdater<List<WorkoutModel>> {
  late final IAuthRepo<User?> _iAuthRepo;
  ListWorkoutModelUpdater({
    required IAuthRepo<User?> iAuthRepo,
  }) {
    _iAuthRepo = iAuthRepo;
  }

  @override
  Stream<List<WorkoutModel>> dataStream() {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final UserModel? currentUser = _iAuthRepo.currentUser;
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    final CollectionReference<Map<String, dynamic>> workoutsCollection =
        db.collection(usersPath).doc(currentUser.uid).collection(programsPath);

    return workoutsCollection.snapshots().asyncMap(
      (QuerySnapshot<Map<String, dynamic>> event) {
        return event.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
                WorkoutModel.fromMap(e.data()))
            .toList();
      },
    );
  }
}
