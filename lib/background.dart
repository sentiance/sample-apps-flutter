import 'package:flutter/material.dart';
import 'package:sample_apps_flutter/src/helpers/log.dart';
import 'package:sentiance_crash_detection/sentiance_crash_detection.dart';
import 'package:sentiance_driving_insights/sentiance_driving_insights.dart';
import 'package:sentiance_event_timeline/sentiance_event_timeline.dart';
import 'package:sentiance_user_context/sentiance_user_context.dart';

/// ================================
/// Sentiance User Context Listener
/// ================================

@pragma('vm:entry-point')
void registerUserContextListener() {
  print("sentiance log: registerUserContextListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceUserContext.registerUserContextUpdateListener((criteria, context) {
    final s = "received user context update event, criteria: ${criteria.toString()} - context: ${context.toString()}";
    print("sentiance log: ${s}");

    writeLog(s);
  });
}

/// ================================
/// Sentiance Event Timeline Listener
/// ================================

@pragma('vm:entry-point')
void registerEventTimelineListener() {
  print("sentiance log: registerEventTimelineListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceEventTimeline.registerEventTimelineUpdateListener((event) {
    print("sentiance log: received timeline event ${event.toString()}");
    writeLog("received timeline event ${event.id}");
  });
}

/// ================================
/// Sentiance Driving Insights Listener
/// ================================

@pragma('vm:entry-point')
void registerDrivingInsightsListener() {
  print("sentiance log: registerDrivingInsightsListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceDrivingInsights.registerDrivingInsightsListener((insights) {
    print("sentiance log: received driving insights ${insights.transportEvent.id}");
    writeLog("received driving insights");
  });
}

/// ================================
/// Sentiance Crash Detection Listener
/// ================================

@pragma('vm:entry-point')
void registerCrashDetectionListener() {
  print("sentiance log: registerCrashDetectionListener backgroundEntryPoint");

  WidgetsFlutterBinding.ensureInitialized();
  SentianceCrashDetection.registerCrashListener((event) {
    print("sentiance log: received crash event at ${event.time}");
    writeLog("received crash event");
  });
  SentianceCrashDetection.registerCrashDiagnosticListener((diagnostic) {
    print("sentiance log: received crash diagnostic ${diagnostic.toString()}");
    writeLog("received crash diagnostic");
  });
}
