import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_helper/app/common/helpers.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';
import 'package:gym_helper/app/settings/navigation/app_router.dart';
import 'package:gym_helper/features/auth/auth_bloc/auth_bloc.dart';

import '../../app/common/ui/asset_paths.dart';
import '../../app/settings/service_locator.dart';

@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconColor = context.colorScheme.mainRedColor;

    return PopScope(
      canPop: false,
      child: BlocProvider<AuthBloc>.value(
        value: ServiceLocator.authBloc,
        child: AutoTabsScaffold(
          routes: const <PageRouteInfo>[
            CalendarRoute(),
            ProgramsRoute(),
            SettingsRoute(),
          ],
          bottomNavigationBuilder:
              (BuildContext context, TabsRouter tabsRouter) {
            return CupertinoTabBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (int tapIndex) {
                if (tabsRouter.activeIndex == tapIndex) {
                  context.router.navigateNamed(
                    context.router.childControllers.first.current.path,
                  );
                }
                tabsRouter.setActiveIndex(tapIndex);
              },
              backgroundColor: Colors.transparent,
              activeColor: context.colorScheme.mainRedColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: context.l10n.calendar,
                  icon: Icon(
                    Icons.calendar_month,
                    color: iconColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: context.l10n.workouts,
                  icon: SvgPicture.asset(
                    AssetPaths.svg.kettlebell,
                    height: 40,
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetPaths.svg.kettlebell,
                    height: 40,
                  ),
                ),
                BottomNavigationBarItem(
                  label: context.l10n.settings,
                  icon: Icon(
                    Icons.settings,
                    color: iconColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
