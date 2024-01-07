import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Календарь',
              icon: Container(
                child: const Icon(Icons.calendar_month),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Календарь',
              icon: Container(
                child: const Icon(Icons.calendar_month),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Календарь',
              icon: Container(
                child: const Icon(Icons.calendar_month),
              ),
            ),
          ],
        );
      },
    );
  }
}
