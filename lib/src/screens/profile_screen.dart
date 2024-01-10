import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'setup_screen.dart';

import '../widgets/label_text.dart';
import '../helpers/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final sentiance = Sentiance();
  String userId = "";
  String initStatus = "";
  String startStatus = "";
  String detectionStatus = "";
  String locationPermissionStatus = "";
  String activityPermissionStatus = "";

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() {
    print("fetching profile information");
    fetchProfile().then((value) {
      setState(() {
        userId = value.userId;
        initStatus = value.initStatus;
        startStatus = value.startStatus;
        detectionStatus = value.detectionStatus;
        locationPermissionStatus = value.locationPermissionStatus;
        activityPermissionStatus = value.activityPermissionStatus;
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

  List<Widget> getChildren() {
    List<Widget> items = [
      const Text('SDK & User Information',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 24)
    ];
    Map<String, String> data = {
      "User ID": userId,
      "Init Status": initStatus,
      "Start Status": startStatus,
      "Detection Status": detectionStatus,
      "Location Permission Status": locationPermissionStatus,
      "Activity Permission Status": activityPermissionStatus,
    };

    data.forEach((key, value) {
      items.addAll([
        LabelText(key: Key(key), label: key, text: value),
        const SizedBox(height: 24)
      ]);
    });

    items.add(ElevatedButton(
      onPressed: () async {
        try {
          await sentiance.reset();
          loadSetup();
        } catch (e) {
          print(e);
        }
      },
      child: const Text('Reset SDK'),
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => fetch(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getChildren(),
        ),
      ),
    );
  }
}
