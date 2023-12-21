import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';

class SetupView extends StatefulWidget {
  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  String message = "Press the button";
  final sentiance = Sentiance();

  Future<void> _updateMessage() async {
    var userId = await sentiance.getUserId();
    print("[sample] sentiance: $userId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("[sample] in the initState");
    print("[sample] sentiance: ${sentiance.getUserId()}");
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
