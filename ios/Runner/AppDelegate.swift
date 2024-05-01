import UIKit
import Flutter
import SENTSDK
import sentiance_core
import sentiance_user_context
import sentiance_event_timeline
import sentiance_driving_insights
import sentiance_crash_detection

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      GeneratedPluginRegistrant.register(with: self)
      initializeSentiance()
    
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func initializeSentiance(){
        let libraryURI = "package:sample_apps_flutter/background.dart"
        
        SentianceCorePlugin.shared.initialize()
        
        GeneratedPluginRegistrant.register(
          with: SentianceUserContextPlugin.initializeListener(
              withEntryPoint: "registerUserContextListener",
              libraryURI: libraryURI
          )
        )
        
        GeneratedPluginRegistrant.register(
            with: SentianceEventTimelinePlugin.initializeListener(
                withEntryPoint: "registerEventTimelineListener",
                libraryURI: libraryURI
            )
        )
        
        GeneratedPluginRegistrant.register(
            with: SentianceDrivingInsightsPlugin.initializeListener(
                withEntryPoint: "registerDrivingInsightsListener",
                libraryURI: libraryURI
            )
        )
        
        GeneratedPluginRegistrant.register(
            with: SentianceCrashDetectionPlugin.initializeListener(
                withEntryPoint: "registerCrashDetectionListener",
                libraryURI: libraryURI
            )
        )
    }

}
