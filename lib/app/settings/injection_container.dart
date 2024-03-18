import 'package:firebase_auth/firebase_auth.dart';

import '../../data/local_storage/secure_storage.dart';
import '../../domain/auth_repo/firebase_auth_repo.dart';
import '../../features/auth/auth_bloc/auth_bloc.dart';
import '../common/error_handler.dart';
import 'navigation/app_router.dart';

final di = Di.instance;

class Di {
  static Di? _instance;
  Di._();

  static Di get instance => _instance ??= Di._();

  T get<T extends Object>() {
    return _diMap[T] as T;
  }

  static final _secureStorage = SecureStorage();

  static final _farebaseAuthRepo = FirebaseAuthRepo(
    firebaseAuth: FirebaseAuth.instance,
    iLocalStorage: _secureStorage,
  );

  final _diMap = <Type, Object>{
    AppRouter: AppRouter(),
    AuthBloc: AuthBloc(iAuthRepo: _farebaseAuthRepo),
    ErrorHandler: ErrorHandler(),
    FirebaseAuthRepo: _farebaseAuthRepo,
    SecureStorage: _secureStorage,
  };
}
