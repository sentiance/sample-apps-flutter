import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:sentiance_plugin/models/create_user_input.dart';
import 'home_screen.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String message = "Press the button";
  final sentiance = Sentiance();

  Future<void> _updateMessage() async {
    if (!context.mounted) return;

    var userId = await sentiance.getUserId();
    print("[sample] sentiance: $userId");
    if (await sentiance.userExists()) {
      if (!context.mounted) return;

      print("[sample] user exists redirecting to /home");
      loadHome();
      return;
    }

    const authCode = "...";

    try {
      var user = await sentiance.createUser(CreateUserInput(authCode));
      print(user);
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
    print("in the init state");

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
        title: Text("Setup View"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _updateMessage,
              child: Text('Create SDK User'),
            ),
          ],
        ),
      ),
    );
  }
}
