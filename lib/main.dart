import 'package:flutter/material.dart';
import 'pages/Homev2.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };

  runApp(MaterialApp(
    title: 'Dublin Transport',
    home: new Home(),
  ));
}