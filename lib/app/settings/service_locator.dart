import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_helper/app/settings/navigation/app_router.dart';
import 'package:gym_helper/data/external_storage/firestore_storage.dart';
import 'package:gym_helper/data/local_storage/secure_storage.dart';
import 'package:gym_helper/domain/auth_repo/firebase_auth_repo.dart';
import 'package:gym_helper/features/auth/auth_bloc/auth_bloc.dart';

import '../../domain/real_time_updater/list_workout_model_updater.dart';
import '../../domain/workout_repo/workout_repo.dart';
import '../../features/add_program/bloc/add_program_bloc.dart';
import '../../features/programs/bloc/programs_bloc.dart';
import '../common/error_handler.dart';

class ServiceLocator {
  static ErrorHandler get erroHandler => const ErrorHandler();

  static final AuthBloc _authBlocSingleton =
      AuthBloc(iAuthRepo: firebaseAuthRepo);
  static AuthBloc get authBloc => _authBlocSingleton;

  static AddProgramBloc get addProgramBloc =>
      AddProgramBloc(workoutRepo: workoutRepo);

  static ProgramsBloc get programsBloc => ProgramsBloc(
        workoutRepo: workoutRepo,
        realTimeUpdater: listWorkoutModelUpdater,
      );

  static FirestoreStorage get firestoreStorage => FirestoreStorage();
  static SecureStorage get secureStorage => SecureStorage();
  static AppRouter get appRouter => AppRouter();
  static WorkoutRepo get workoutRepo => WorkoutRepo(
        externalStorage: firestoreStorage,
        iAuthRepo: firebaseAuthRepo,
      );

  static ListWorkoutModelUpdater get listWorkoutModelUpdater =>
      ListWorkoutModelUpdater(
        iAuthRepo: firebaseAuthRepo,
      );

  static FirebaseAuthRepo get firebaseAuthRepo => FirebaseAuthRepo(
        firebaseAuth: FirebaseAuth.instance,
        iExternalStorage: firestoreStorage,
        iLocalStorage: secureStorage,
      );
}
