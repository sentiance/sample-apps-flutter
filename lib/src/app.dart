import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';
import 'screens/home_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SetupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
