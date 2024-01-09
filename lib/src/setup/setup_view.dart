import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:sentiance_plugin/models/create_user_input.dart';
import '../screens/home_screen.dart';

class SetupView extends StatefulWidget {
  static const routeName = '/';

  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
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

    const authCode =
        "3bfb19bb837b620b45785c7a8bdc93a14beb6b235a68408afcc782147c577bd8e115647c09a79966e0f58702684350a784a11511ac8652b5bbde910d132865d9";

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
