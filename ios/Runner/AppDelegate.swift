import UIKit
import Flutter
import GoogleMaps
import flutter_downloader

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//       GMSServices.provideAPIKey("AIzaSyA0OHjt2yWfpS5BUUUMVquLZ2cRE_hwksA")
    GMSServices.provideAPIKey("AIzaSyCl23apLBSkhrTjrY-mg1JprhmtmClrZm0")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func registerPlugins(registry: FlutterPluginRegistry) {
      if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
         FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
      }
}