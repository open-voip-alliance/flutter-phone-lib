import UIKit
import Flutter
import flutter_phone_lib

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let registerPlugins = GeneratedPluginRegistrant.register
    registerPlugins(self)

    startPhoneLib(
      registerPlugins,
      nativeMiddleware: ExampleMiddleware(),
      onLogReceived: { message, level in
        print("\(level): \(message)")
      }
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
