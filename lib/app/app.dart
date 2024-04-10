import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:gym_helper/app/common/theme_manager/theme_manager.dart';
import 'settings/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final botToastBuilder = BotToastInit();
final _appRouter = ServiceLocator.appRouter;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: Themes.getLightTheme(),
      dark: Themes.getDarkTheme(),
      builder: (light, dark) => MediaQuery(
        // Disable pinch zooming
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate(
            _appRouter,
            navigatorObservers: () => [
              BotToastNavigatorObserver(),
            ],
          ),
          theme: light,
          darkTheme: dark,
          builder: (context, router) => botToastBuilder(
            context,
            router,
          ),
        ),
      ),
    );
  }
}
