abstract interface class IWorkoutRepo {
  Future<void> addWorkout({required String name, String? description});
}
