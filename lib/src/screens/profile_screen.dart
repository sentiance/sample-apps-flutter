import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

import 'setup_screen.dart';
import '../widgets/label_text.dart';
import '../helpers/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  final sentiance = Sentiance();
  String userId = "";
  String initStatus = "";
  String startStatus = "";
  String detectionStatus = "";
  String locationPermissionStatus = "";
  String activityPermissionStatus = "";
  bool enablePermissionButton = false;
  String requestButtonTitle = "...";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetch();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
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

    Permission.locationAlways.status.then((value) {
      setState(() {
        enablePermissionButton = !value.isGranted;
      });
    });

    determineRequestPermissionTitle();
  }

  void loadSetup() {
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SetupScreen()),
      (Route<dynamic> route) => false,
    );
  }

  List<Widget> getRequestPermissions() {
    return [
      ElevatedButton(
        onPressed: enablePermissionButton
            ? () {
                requestPermission();
              }
            : null,
        child: Text(requestButtonTitle),
      )
    ];
  }

  determineRequestPermissionTitle() async {
    PermissionStatus permissionAlways = await Permission.locationAlways.status;
    PermissionStatus permission = await Permission.location.status;
    String title = "Request Permissions";

    if (permissionAlways.isGranted) {
      title = "Permissions Granted";
    } else if (permission.isGranted) {
      title = "Request Always Permission";
    }

    setState(() {
      requestButtonTitle = title;
    });
  }

  Future<void> requestPermission() async {
    if (await Permission.locationAlways.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    if (await Permission.location.isGranted) {
      await Permission.locationAlways.request();
      return;
    }

    await Permission.location.request();
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
      "Location Permission Status": locationPermissionStatus
    };

    data.forEach((key, value) {
      items.addAll([
        LabelText(key: Key(key), label: key, text: value),
        const SizedBox(height: 24)
      ]);
    });

    items.addAll(getRequestPermissions());
    items.addAll([
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
      )
    ]);

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
