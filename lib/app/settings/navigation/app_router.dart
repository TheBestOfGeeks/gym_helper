import 'package:auto_route/auto_route.dart';

import '../../../features/auth/view/auth_page.dart';
import '../../../features/init/view/init_page.dart';
import '../../../features/navigation/navigation_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitRoute.page, initial: true),
        AutoRoute(page: NavigationRoute.page),
        AutoRoute(page: AuthRoute.page),
      ];
}
