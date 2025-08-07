
import 'package:flutter/services.dart';

import 'my_awesome_plugin_platform_interface.dart';

class MyAwesomePlugin {
  static const MethodChannel _channel = MethodChannel('my_awesome_plugin');
  
  Future<String?> getPlatformVersion() {
    return MyAwesomePluginPlatform.instance.getPlatformVersion();
  }
  static Future<int?> get batteryLevel async {
    try {
      final int? result = await _channel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
      return null;
    }
  }

  // Send data to platform
  static Future<String?> processData(String data) async {
    try {
      final String? result = await _channel.invokeMethod('processData', {'data': data});
      return result;
    } on PlatformException catch (e) {
      print("Failed to process data: '${e.message}'.");
      return null;
    }
  }
}
