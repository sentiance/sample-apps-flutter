import 'package:flutter/material.dart';
import 'package:sample_apps_flutter/src/helpers/log.dart';
import 'package:sentiance_crash_detection/api.g.dart';
import 'package:sentiance_event_timeline/sentiance_event_timeline.dart';
import 'package:sentiance_driving_insights/sentiance_driving_insights.dart';
import 'package:sentiance_user_context/sentiance_user_context.dart';
import 'package:sentiance_crash_detection/sentiance_crash_detection.dart';

/// ================================
/// Sentiance User Context Listener
/// ================================

@pragma('vm:entry-point')
void registerUserContextListener() {
  print("sentiance log: registerUserContextListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceUserContextListenerApi.setUp(UserContextHandler());
}

class UserContextHandler extends SentianceUserContextListenerApi {
  @override
  void didUpdate(UserContextUpdateCriteria? criteria) {
    final s = "received user context update event ${criteria.toString()}";
    print("sentiance log: ${s}");

    writeLog(s);
  }
}

/// ================================
/// Sentiance Event Timeline Listener
/// ================================

@pragma('vm:entry-point')
void registerEventTimelineListener() {
  print("sentiance log: registerEventTimelineListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceEventTimelineListenerApi.setUp(EventTimelineHandler());
}

class EventTimelineHandler extends SentianceEventTimelineListenerApi {
  @override
  void onTimelineUpdated(TimelineEvent event) {
    print("sentiance log: received timeline event ${event.toString()}");
    writeLog("received timeline event ${event.id}");
  }
}

/// ================================
/// Sentiance Driving Insights Listener
/// ================================

@pragma('vm:entry-point')
void registerDrivingInsightsListener() {
  print("sentiance log: registerDrivingInsightsListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceDrivingInsightsListenerApi.setUp(DrivingInsightsHandler());
}

class DrivingInsightsHandler extends SentianceDrivingInsightsListenerApi {
  @override
  void onDrivingInsightsReady(DrivingInsights insights) {
    print(
        "sentiance log: received driving insights ${insights.transportEvent.id}");
    writeLog("received driving insights");
  }
}

/// ================================
/// Sentiance Crash Detection Listener
/// ================================

@pragma('vm:entry-point')
void registerCrashDetectionListener() {
  print("sentiance log: registerCrashDetectionListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceCrashDetectionListenerApi.setUp(CrashDetectionHandler());
}

class CrashDetectionHandler extends SentianceCrashDetectionListenerApi {
  @override
  void onVehicleCrashEvent(CrashEvent event) {
    print("sentiance log: received crash event at ${event.time}");

    writeLog("received crash event");
  }

  @override
  void onVehicleCrashDiagnostic(VehicleCrashDiagnostic diagnostic) {
    print("sentiance log: received crash diagnostic ${diagnostic.toString()}");

    writeLog("received crash diagnostic");
  }
}
