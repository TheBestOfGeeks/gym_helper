import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_helper/domain/auth_repo/i_auth_repo.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepo iAuthRepo;

  AuthBloc({required this.iAuthRepo}) : super(const _Initial()) {
    on<AuthEvent>((event, emit) {
      event.map(
        singIn: (event) => _singIn(event, emit),
      );
    });
  }

  _singIn(_SingIn event, Emitter<AuthState> emit) async {
    debugPrint('singIn event');
    await iAuthRepo.signIn(event.email, event.password);
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.singIn(String email, String password) = _SingIn;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.signed() = _Signed;
}
