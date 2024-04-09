// import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentiance_plugin/sentiance_plugin.dart';

class ProfileResult {
  final String userId;
  final String initStatus;
  final String startStatus;
  final String detectionStatus;
  final String locationPermissionStatus;
  final String activityPermissionStatus;

  ProfileResult(
      this.userId,
      this.initStatus,
      this.startStatus,
      this.detectionStatus,
      this.locationPermissionStatus,
      this.activityPermissionStatus);
}

Future<ProfileResult> fetchProfile() async {
  final sentiance = SentiancePlugin();

  var userId = await sentiance.getUserId();
  var initStatus = ""; //await sentiance.getInitState();
  var sdkStatus = ""; //await sentiance.getSdkStatus();
  var startStatus = ""; //sdkStatus.startStatus;
  var detectionStatus =
      (await sentiance.getSdkStatus()).detectionStatus.toString();

  return ProfileResult(
    userId!,
    initStatus.toString(),
    startStatus,
    detectionStatus,
    await getLocationPermissionStatus(),
    "",
  );
}

Future<String> getLocationPermissionStatus() async {
  PermissionStatus permissionWhenInUse =
      await Permission.locationWhenInUse.status;
  PermissionStatus permissionAlways = await Permission.locationAlways.status;

  if (permissionAlways.isGranted) {
    return "Always";
  } else if (permissionWhenInUse.isGranted) {
    return "When in use";
  }

  return (await Permission.location.status).toString();
}
