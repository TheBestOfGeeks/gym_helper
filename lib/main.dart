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
      configureDependencies();
      Bloc.observer = StateObserver();
      Bloc.transformer = sequential();
      runApp(const App());
    },
    (error, stack) {},
  );
}
