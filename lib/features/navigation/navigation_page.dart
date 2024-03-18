import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_helper/app/settings/navigation/app_router.dart';

import '../../app/settings/injection_container.dart';
import '../auth/auth_bloc/auth_bloc.dart';

@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: di.get<AuthBloc>(),
        child: AutoTabsScaffold(
          routes: const [
            CalendarRoute(),
            CalendarRoute(),
            SettingsRoute(),
          ],
          bottomNavigationBuilder: (context, tabsRouter) {
            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                  label: 'Календарь',
                  icon: Icon(Icons.calendar_month),
                ),
                BottomNavigationBarItem(
                  label: 'Тренировка',
                  icon: Icon(Icons.calendar_month),
                ),
                BottomNavigationBarItem(
                  label: 'Настройки',
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
