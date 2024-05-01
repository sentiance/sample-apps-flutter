package com.example.sample_apps_flutter

import io.flutter.app.FlutterApplication
import com.sentiance.core_plugin.CorePlugin
import com.sentiance.user_context_plugin.UserContextPlugin
import com.sentiance.event_timeline_plugin.EventTimelinePlugin
import com.sentiance.driving_insights_plugin.DrivingInsightsPlugin
import com.sentiance.crash_detection_plugin.CrashDetectionPlugin

class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        initializeSentiance()
    }

    fun initializeSentiance() {
        val dartLibrary = "package:sample_apps_flutter/background.dart"

        CorePlugin.initialize(this)
        UserContextPlugin.initializeListener(this, dartLibrary, "registerUserContextListener")
        EventTimelinePlugin.initializeListener(this, dartLibrary, "registerEventTimelineListener")
        DrivingInsightsPlugin.initializeListener(this, dartLibrary, "registerDrivingInsightsListener")
        CrashDetectionPlugin.initializeListener(this, dartLibrary, "registerCrashDetectionListener")
    }

}