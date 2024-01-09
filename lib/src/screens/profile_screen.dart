import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'setup_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// boilerplate for the simple stateful widget
class _ProfileScreenState extends State<ProfileScreen> {
  final sentiance = Sentiance();

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
          children: [
            const Text(
              'Profile Content',
              style: TextStyle(fontSize: 20),
            ),
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
