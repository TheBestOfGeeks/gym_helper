import 'package:gym_helper/domain/auth_repo/models/user_model.dart';

abstract interface class IAuthRepo<T> {
  UserModel? get currentUser;

  Stream<T> get authStateChanges;

  Future<bool> needRefreshToken(String newRefreshToken);

  Future<bool> signIn(String email, String password);

  Future<void> registration(String email, String password);

  Future<void> singOut();
}
