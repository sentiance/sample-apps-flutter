package com.example.sample_apps_flutter

import android.util.Log
import io.flutter.app.FlutterApplication
import com.sentiance.core_plugin.CorePlugin

class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        Log.v("[Sentiance]", "MainApplication onCreate")

        var result = CorePlugin.initialize(this)

        if (result.isSuccessful) {
            Log.v("[Sentiance]", "initialization successful");
        } else {
            Log.v("[Sentiance]", "initialization failed");
        }
    }

}