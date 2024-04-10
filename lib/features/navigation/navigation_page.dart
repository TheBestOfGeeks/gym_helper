import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_helper/app/common/helpers.dart';
import 'package:gym_helper/app/settings/navigation/app_router.dart';

import '../../app/settings/service_locator.dart';

@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: ServiceLocator.authBloc,
        child: AutoTabsScaffold(
          routes: const [
            CalendarRoute(),
            WorkoutsRoute(),
            SettingsRoute(),
          ],
          bottomNavigationBuilder: (context, tabsRouter) {
            return CupertinoTabBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (tapIndex) {
                if (tabsRouter.activeIndex == tapIndex) {
                  context.router.navigateNamed(
                    context.router.childControllers.first.current.path,
                  );
                }
                tabsRouter.setActiveIndex(tapIndex);
              },
              backgroundColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  label: context.l10n.calendar,
                  icon: const Icon(Icons.calendar_month),
                ),
                BottomNavigationBarItem(
                  label: context.l10n.workouts,
                  icon: const Icon(Icons.calendar_month),
                ),
                BottomNavigationBarItem(
                  label: context.l10n.settings,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
