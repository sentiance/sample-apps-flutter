package com.example.sample_apps_flutter

import com.sentiance.sentiance_plugin.SentianceHelper
import io.flutter.app.FlutterApplication

class MainApplication : FlutterApplication() {

    private lateinit var sentianceHelper: SentianceHelper

    override fun onCreate() {
        super.onCreate()
        sentianceHelper = SentianceHelper.getInstance(this);
        sentianceHelper.initialize();
    }

}