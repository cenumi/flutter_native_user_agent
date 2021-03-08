import Flutter
import UIKit

public class SwiftFlutterNativeUserAgentPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_native_user_agent", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterNativeUserAgentPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getCfnVersion":
        result(getCfnVersion())
    default:
        result(FlutterMethodNotImplemented)
    }
  }
    
    func getCfnVersion() -> String {
        return Bundle.init(identifier: "com.apple.CFNetwork")?.infoDictionary?["CFBundleShortVersionString"] as! String
    }
}
