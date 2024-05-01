import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_apps_flutter/src/helpers/utils.dart';
import 'package:sentiance_core/sentiance_core.dart';
import 'package:sentiance_user_context/sentiance_user_context.dart';
import 'package:sentiance_event_timeline/sentiance_event_timeline.dart'
    as timeline;
import 'package:sentiance_crash_detection/sentiance_crash_detection.dart';

import 'setup_screen.dart';
import '../widgets/label_text.dart';
import '../helpers/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  final sentiance = SentianceCore();
  final userContext = SentianceUserContext();
  final sentianceCrashDetection = SentianceCrashDetection();

  String userId = "-";
  String detectionStatus = "-";
  String locationPermissionStatus = "";
  String activityPermissionStatus = "";
  String sdkVersion = "";
  String lastKnownLocation = "-";
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

  Future<void> fetch() async {
    var profile = await fetchProfile();
    var permission = await Permission.locationAlways.status;
    var version = await sentiance.getVersion();

    try {
      var uc = await userContext.requestUserContext();

      setState(() {
        if (uc.lastKnownLocation?.latitude != null &&
            uc.lastKnownLocation?.longitude != null) {
          lastKnownLocation =
              "${uc.lastKnownLocation?.latitude}, ${uc.lastKnownLocation?.longitude}";
        }

        lastKnownLocation = formatGeoLocation(timeline.GeoLocation(
            latitude: uc.lastKnownLocation?.latitude,
            longitude: uc.lastKnownLocation?.longitude));
      });
    } catch (e) {
      print("sentiance log: error: $e");
    }

    setState(() {
      userId = profile.userId;
      detectionStatus = profile.detectionStatus;
      locationPermissionStatus = profile.locationPermissionStatus;
      activityPermissionStatus = profile.activityPermissionStatus;
      sdkVersion = version;

      // Enable request permission button if permission is not granted
      enablePermissionButton = !permission.isGranted;
    });

    determineRequestPermissionTitle();
  }

  void loadSetup() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SetupScreen()),
      (Route<dynamic> route) => false,
    );
  }

  List<Widget> getRequestPermissions() {
    return [
      ElevatedButton(
        onPressed: enablePermissionButton ? requestPermission : null,
        child: Text(requestButtonTitle),
      )
    ];
  }

  Widget getSimulateCrashButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Crash Detection",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: simulateCrash,
          child: Text(
            "Simulate a crash",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  simulateCrash() async {
    await sentianceCrashDetection.invokeDummyVehicleCrash();
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
      "SDK Version": sdkVersion,
      "Detection Status": detectionStatus,
      "Last Known Location": lastKnownLocation,
      "Location Permission Status": locationPermissionStatus,
    };

    data.forEach((key, value) {
      items.addAll([
        LabelText(key: Key(key), label: key, text: value),
        const SizedBox(height: 24)
      ]);
    });

    items.addAll([getSimulateCrashButton(), const SizedBox(height: 24)]);

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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Profile'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => fetch(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getChildren(),
      ),
    ));
  }
}
