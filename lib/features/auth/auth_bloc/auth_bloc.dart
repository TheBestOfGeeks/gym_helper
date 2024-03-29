import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:gym_helper/domain/auth_repo/i_auth_repo.dart';

part 'auth_bloc.freezed.dart';

enum AuthStatus {
  authorized,
  notAuthorized,
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepo iAuthRepo;

  AuthBloc({required this.iAuthRepo})
      : super(const _Initial(authStatus: AuthStatus.notAuthorized)) {
    on<AuthEvent>(
      (event, emit) async {
        await event.map<Future<void>>(
          signIn: (event) async => await _onSingIn(event, emit),
          sign: (event) async => _onSinged(emit),
          signOut: (event) async => _onSingOut(emit),
          initialization: (event) async => _onInitialization(),
        );
      },
      transformer: droppable(),
    );
    add(const AuthEvent.initialization());
  }

  void _onSinged(Emitter<AuthState> emitter) {
    emitter(const AuthState.autenticaticated(
      authStatus: AuthStatus.authorized,
    ));
  }

  void _onSingOut(Emitter<AuthState> emitter) {
    iAuthRepo.singOut();
    emitter(const AuthState.unAutenticaticated(
      authStatus: AuthStatus.notAuthorized,
    ));
  }

  Future<void> _onSingIn(_SignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading(authStatus: AuthStatus.notAuthorized));
    try {
      await iAuthRepo.signIn(event.email, event.password);
      add(const AuthEvent.sign());
    } catch (e) {
      emit(const AuthState.loading(authStatus: AuthStatus.notAuthorized));
      if (e is FirebaseAuthException) {
        final errorCode = e.code;
        switch (errorCode) {
          case 'INVALID_LOGIN_CREDENTIALS':
            emit(const AuthState.error(
              error: 'Неправильный логин или пароль',
              authStatus: AuthStatus.notAuthorized,
            ));
            break;
          default:
            emit(const AuthState.error(
              error: 'Ой, что-то пошло не так...',
              authStatus: AuthStatus.notAuthorized,
            ));
            break;
        }
      } else {
        emit(const AuthState.error(
          error: 'Ой, что-то пошло не так...',
          authStatus: AuthStatus.notAuthorized,
        ));
      }

      addError(e);
    }
  }

  void _onInitialization() async {
    bool isRefreshTokenExpired = false;
    iAuthRepo.authStateChanges.asyncMap((user) async {
      final userData = user as User?;
      if (userData != null) {
        isRefreshTokenExpired =
            await iAuthRepo.needRefreshToken(userData.refreshToken ?? '');
      }

      return userData;
    }).listen((user) {
      if (user == null &&
          (isRefreshTokenExpired ||
              state.getAuthStatus == AuthStatus.authorized)) {
        add(const AuthEvent.signOut());
      } else if (user != null && !isRefreshTokenExpired) {
        add(const AuthEvent.sign());
      }
    });
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialization() = _Initialization;
  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = _SignIn;
  const factory AuthEvent.sign() = _Sign;
  const factory AuthEvent.signOut() = _SignOut;
}

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  AuthStatus get getAuthStatus => map<AuthStatus>(
        autenticaticated: (state) => state.authStatus,
        unAutenticaticated: (state) => state.authStatus,
        initial: (state) => state.authStatus,
        error: (state) => state.authStatus,
        loading: (state) => state.authStatus,
      );

  const factory AuthState.initial({
    required AuthStatus authStatus,
  }) = _Initial;
  const factory AuthState.loading({
    required AuthStatus authStatus,
  }) = _Loading;
  const factory AuthState.autenticaticated({
    required AuthStatus authStatus,
  }) = _Autenticaticated;
  const factory AuthState.unAutenticaticated({
    required AuthStatus authStatus,
  }) = _UnAutenticaticated;
  const factory AuthState.error({
    required String error,
    required AuthStatus authStatus,
  }) = _Error;
}
