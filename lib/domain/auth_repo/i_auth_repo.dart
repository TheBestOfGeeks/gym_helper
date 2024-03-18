import 'package:gym_helper/domain/auth_repo/models/user_model.dart';

abstract interface class IAuthRepo {
  UserModel? get currentUserUid;

  Stream get authStateChanges;

  Future<bool> needRefreshToken(String newRefreshToken);

  Future<void> signIn(String email, String password);

  Future<void> registration(String email, String password);

  Future<void> singOut();
}
