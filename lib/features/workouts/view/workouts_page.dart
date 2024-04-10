import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/settings/navigation/app_router.dart';
import '../bloc/workouts_bloc.dart';

@RoutePage()
class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutsBloc(),
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () => context.router.push(const AddWorkoutRoute()),
          icon: const Icon(Icons.add),
          iconSize: 40,
        ),
        body: const CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
            ),
            SliverToBoxAdapter(),
          ],
        ),
      ),
    );
  }
}
