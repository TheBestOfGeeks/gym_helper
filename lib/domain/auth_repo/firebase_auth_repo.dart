import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_helper/domain/auth_repo/i_auth_repo.dart';

import '../../data/local_storage/local_storage_interface.dart';
import 'models/user_model.dart';

const String _refreshTokenKey = 'refresh_token';

class FirebaseAuthRepo implements IAuthRepo {
  late final FirebaseAuth _firebaseAuth;
  late final ILocalStorage _localStorage;

  FirebaseAuthRepo({
    required FirebaseAuth firebaseAuth,
    required ILocalStorage iLocalStorage,
  }) {
    _firebaseAuth = firebaseAuth;
    _localStorage = iLocalStorage;
  }

  @override
  UserModel? get currentUserUid {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return UserModel(
      email: user.email,
      uid: user.uid,
      refreshToken: user.refreshToken,
    );
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String? refreshToken = userCredential.user?.refreshToken;
      if (refreshToken != null) {
        await _localStorage.setData<String>(_refreshTokenKey, refreshToken);
      }
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> registration(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> singOut() async {
    try {
      await _localStorage.deleteData(_refreshTokenKey);
      await _firebaseAuth.signOut();
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<bool> needRefreshToken(String newRefreshToken) async {
    final oldRefreshToken =
        await _localStorage.getData<String>(_refreshTokenKey);

    return oldRefreshToken != newRefreshToken;
  }
}
