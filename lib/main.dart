import 'package:flutter/material.dart';
import 'pages/Home.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'dart:async';

void main() async {
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(MaterialApp(
      title: 'IPT ALPHA',
      home: new HomePage(),
    ));
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
  });


}