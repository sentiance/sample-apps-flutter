import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'setup_screen.dart';

import '../widgets/label_text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// boilerplate for the simple stateful widget
class _ProfileScreenState extends State<ProfileScreen> {
  final sentiance = Sentiance();
  String userId = "";
  String initStatus = "";
  String startStatus = "";

  @override
  void initState() {
    super.initState();

    sentiance.getUserId().then((value) {
      setState(() {
        userId = value!;
      });
    });
  }

  void loadSetup() {
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SetupScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SDK & User Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            LabelText(key: Key("sdk-user-id"), label: "User ID", text: userId),
            const SizedBox(height: 24),
            LabelText(
                key: Key("init-status"),
                label: "Init Status",
                text: "(pending)"),
            const SizedBox(height: 24),
            LabelText(
                key: Key("start-status"),
                label: "Start Status",
                text: "(pending)"),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                try {
                  await sentiance.reset();
                  loadSetup();
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Reset SDK'),
            ),
          ],
        ),
      ),
    );
  }
}
