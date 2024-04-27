import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/workout_repo/models/workout_model.dart';
import '../../../features/add_program/view/add_program_page.dart';
import '../../../features/auth/view/auth_page.dart';
import '../../../features/calendar/view/calendar_page.dart';
import '../../../features/init/view/init_page.dart';
import '../../../features/navigation/navigation_page.dart';
import '../../../features/programs/view/programs_initial_page.dart';
import '../../../features/programs/view/programs_page.dart';
import '../../../features/settings/view/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: InitRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(
          page: NavigationRoute.page,
          children: <AutoRoute>[
            AutoRoute(page: CalendarRoute.page),
            AutoRoute(
              page: ProgramsInitialRoute.page,
              children: <AutoRoute>[
                AutoRoute(
                  page: ProgramsRoute.page,
                  initial: true,
                ),
                AutoRoute(page: AddProgramRoute.page),
              ],
            ),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
      ];
}
