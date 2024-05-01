import 'package:flutter/material.dart';
import 'package:sample_apps_flutter/src/helpers/log.dart';
import 'src/app.dart';

// Importing background.dart is necessary if the entry points for background
// Tasks are defined in this file. Even if no methods from background.dart are
// called in this file, the Dart compiler will still include background.dart
// in the application bundle because it's imported here.

// ignore: unused_import
import 'background.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  requestFilePermissions();
}
