import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'my_awesome_plugin_platform_interface.dart';
import 'package:flutter/material.dart';

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
      final String? result = await _channel.invokeMethod('processData', {
        'data': data,
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to process data: '${e.message}'.");
      return null;
    }
  }

  static Widget batteryWidget({
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    double width = 200,
    double height = 100,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    BorderRadius? borderRadius,
  }) {
    return BatteryLevelWidget(
      backgroundColor: backgroundColor,
      textColor: textColor,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    );
  }
}

class BatteryLevelWidget extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const BatteryLevelWidget({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.width,
    required this.height,
    required this.padding,
    required this.borderRadius,
  }) : super(key: key);

  @override
  State<BatteryLevelWidget> createState() => _BatteryLevelWidgetState();
}

class _BatteryLevelWidgetState extends State<BatteryLevelWidget> {
  int? batteryLevel;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  Future<void> _getBatteryLevel() async {
    try {
      final level = await MyAwesomePlugin.batteryLevel;
      setState(() {
        batteryLevel = level;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  // Method to refresh battery level
  Future<void> _refreshBatteryLevel() async {
    setState(() {
      isLoading = true;
    });
    await _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: _refreshBatteryLevel,
        borderRadius: widget.borderRadius,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.battery_full, color: widget.textColor, size: 25),
                const SizedBox(width: 10,),
                Text('${batteryLevel ?? 0}%'),
              ],
            ),
            Text(
              'Battery Level',
              style: TextStyle(
                color: widget.textColor.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
