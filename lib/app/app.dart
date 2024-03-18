import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import 'common/themes.dart';
import 'settings/injection_container.dart';
import 'settings/navigation/app_router.dart';

final botToastBuilder = BotToastInit();
final _appRouter = di.get<AppRouter>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      // Disable pinch zooming
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        builder: (context, router) => botToastBuilder(
          context,
          router,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: Themes.getLightTheme(context),
        routerDelegate: AutoRouterDelegate(
          _appRouter,
          navigatorObservers: () => [
            BotToastNavigatorObserver(),
          ],
        ),
      ),
    );
  }
}
