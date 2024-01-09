import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:sentiance_plugin/models/create_user_input.dart';
import 'home_screen.dart';

import '../helpers/auth.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final sentiance = Sentiance();

  Future<void> _updateMessage() async {
    final AuthCodeResult result = await fetchAuthCode();

    try {
      await sentiance.createUser(CreateUserInput(result.authCode));
      loadHome();
    } catch (e) {
      print(e);
    }
  }

  void loadHome() {
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();

    /**
     * Redirect to home screen if user exists
     */
    Future.microtask(() async {
      if (await sentiance.userExists()) {
        loadHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sentiance"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Click the button below to create a Sentiance SDK user.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: _updateMessage,
              child: const Text('Create SDK User'),
            ),
          ],
        ),
      ),
    );
  }
}
