import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';

import '../../../app/settings/service_locator.dart';
import '../../../domain/auth_repo/firebase_auth_repo.dart';
import '../../auth/auth_bloc/auth_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  FirebaseAuthRepo get _authRepo => ServiceLocator.firebaseAuthRepo;

  @override
  Widget build(BuildContext context) {
    final String? test = _authRepo.currentUser?.refreshToken;
    final bool isLightTheme =
        context.adaptiveTheme.mode == AdaptiveThemeMode.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Text('$test'),
          CupertinoSwitch(
            value: isLightTheme ? false : true,
            onChanged: (bool value) {
              if (isLightTheme) {
                context.adaptiveTheme.setDark();
              } else {
                context.adaptiveTheme.setLight();
              }
            },
          ),
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
