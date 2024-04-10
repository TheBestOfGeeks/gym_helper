import 'package:auto_route/auto_route.dart';

import '../../../features/add_workout/view/add_workout_page.dart';
import '../../../features/auth/view/auth_page.dart';
import '../../../features/calendar/view/calendar_page.dart';
import '../../../features/init/view/init_page.dart';
import '../../../features/navigation/navigation_page.dart';
import '../../../features/settings/view/settings_page.dart';
import '../../../features/workouts/view/workouts_initial_page.dart';
import '../../../features/workouts/view/workouts_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: InitRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(
          page: NavigationRoute.page,
          children: [
            AutoRoute(page: CalendarRoute.page),
            AutoRoute(
              page: WorkoutInitialRoute.page,
              children: [
                AutoRoute(
                  page: WorkoutsRoute.page,
                  initial: true,
                ),
                AutoRoute(page: AddWorkoutRoute.page),
              ],
            ),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
      ];
}
