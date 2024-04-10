import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'app/settings/state_observer.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();

      await Firebase.initializeApp();
      Bloc.observer = StateObserver();
      Bloc.transformer = sequential();
      runApp(const App());
    },
    (error, stack) {
      logger.e('Unhandled error catched by runZonedGuarded', error, stack);
    },
  );
}
