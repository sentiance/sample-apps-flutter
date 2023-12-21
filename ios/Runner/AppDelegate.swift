import UIKit
import Flutter
import sentiance_plugin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let result = SentianceHelper.shared.initialize()
      if result.isSuccessful {
          print("[sample] sdk initialized")
      }  else {
          print("[sample] error initializing sdk")
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
