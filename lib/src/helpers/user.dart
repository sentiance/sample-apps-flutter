import 'package:sentiance_plugin/sentiance_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final sentiance = Sentiance();
  PermissionStatus permission = await Permission.location.status;

  var userId = await sentiance.getUserId();
  var initStatus = await sentiance.getInitState();
  var sdkStatus = await sentiance.getSdkStatus();
  var startStatus = sdkStatus.startStatus;
  var detectionStatus = sdkStatus.detectionStatus;

  return ProfileResult(
    userId!,
    initStatus.toString(),
    startStatus,
    detectionStatus,
    permission.toString(),
    "",
  );
}
