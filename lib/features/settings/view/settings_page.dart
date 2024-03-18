import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/settings/injection_container.dart';
import '../../../domain/auth_repo/firebase_auth_repo.dart';
import '../../auth/auth_bloc/auth_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  FirebaseAuthRepo get _authRepo => di.get<FirebaseAuthRepo>();

  @override
  Widget build(BuildContext context) {
    final test = _authRepo.currentUserUid?.refreshToken;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text('$test'),
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.signOut());
            },
          ),
        ],
      ),
    );
  }
}
