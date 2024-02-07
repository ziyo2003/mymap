import UIKit
import Flutter
import YandexMapsMobile
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCX7FHTghJv1nXvajYjc13Ii_lUFO9caX4")
    YMKMapKit.setApiKey("046ea181-62ec-4f93-b500-cf5f9227031c")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
