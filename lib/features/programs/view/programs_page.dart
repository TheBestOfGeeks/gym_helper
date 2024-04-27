import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';
import 'package:gym_helper/domain/workout_repo/models/workout_model.dart';

import '../../../app/common/ui/widgets/app_bar_manager.dart';
import '../../../app/common/ui/widgets/gim_progress_indicator.dart';
import '../../../app/settings/navigation/app_router.dart';
import '../../../app/settings/service_locator.dart';
import '../bloc/programs_bloc.dart';

@RoutePage()
class ProgramsPage extends StatelessWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProgramsBloc>(
      create: (BuildContext context) => ServiceLocator.programsBloc,
      child: BlocBuilder<ProgramsBloc, ProgramsState>(
        builder: (BuildContext context, ProgramsState state) {
          return Scaffold(
            floatingActionButton: IconButton(
              onPressed: () => context.router.push(AddProgramRoute()),
              icon: const Icon(Icons.add),
              iconSize: 50,
              color: context.colorScheme.mainRedColor,
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                AppBarManager.getSliverAppBar(context),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  sliver: state.when(
                    initial: () {
                      return const SliverFillRemaining(
                        child: GimProgressIndicator(),
                      );
                    },
                    loaded: (List<WorkoutModel> programs) {
                      return SliverList.builder(
                        itemCount: programs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 15.0,
                                    color: context.colorScheme.mainRedColor
                                        .withOpacity(0.1),
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    context.router.push(
                                      AddProgramRoute(
                                        workoutModel: programs[index],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(programs[index].name),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
