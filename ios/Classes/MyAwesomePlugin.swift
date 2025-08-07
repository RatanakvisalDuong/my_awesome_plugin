import Flutter
import UIKit

public class MyAwesomePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_awesome_plugin", binaryMessenger: registrar.messenger())
    let instance = MyAwesomePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getBatteryLevel":
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery level not available.",
                          details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    case "processData":
      if let args = call.arguments as? Dictionary<String, Any>,
         let data = args["data"] as? String {
        let processedData = "Processed: \(data.uppercased())"
        result(processedData)
      } else {
        result("Processed: No data")
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}