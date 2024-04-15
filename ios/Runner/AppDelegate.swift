import UIKit
import Flutter
import SENTSDK
import sentiance_core

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      let result = SentianceCorePlugin.shared.initialize()
      if result.isSuccessful {
          print("[sentiance] sdk initialized")
      }  else {
          print("[sentiance] error initializing sdk")
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
