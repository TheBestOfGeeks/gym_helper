import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_helper/app/settings/navigation/app_router.dart';
import 'package:gym_helper/features/init/bloc/init_bloc.dart';

@RoutePage()
class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBloc(),
      child: BlocConsumer<InitBloc, InitState>(
        listener: (context, state) {
          state.mapOrNull(
            loaded: (value) => context.router.replace(const AuthRoute()),
          );
        },
        builder: (context, state) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
