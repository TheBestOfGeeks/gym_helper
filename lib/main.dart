import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/settings/injection_container.dart';
import 'app/settings/state_observer.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();

      configureDependencies();
      Bloc.observer = StateObserver();
      Bloc.transformer = sequential();
      runApp(App());
    },
    (error, stack) {
      logger.e('Unhandled error catched by runZonedGuarded', error, stack);
    },
  );
}
