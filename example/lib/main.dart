// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:my_awesome_plugin/my_awesome_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _batteryLevel = 0;
  String _processedData = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion = await MyAwesomePlugin().getPlatformVersion() ?? 'Unknown';
    int batteryLevel = await MyAwesomePlugin.batteryLevel ?? 0;
    
    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> processData() async {
    String result = await MyAwesomePlugin.processData("hello world") ?? '';
    setState(() {
      _processedData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Plugin Example')),
        body: Center(
          child: Column(
            children: [
              Text('Platform: $_platformVersion'),
              Text('Battery Level: $_batteryLevel%'),
              ElevatedButton(
                onPressed: processData,
                child: Text('Process Data'),
              ),
              Text('Result: $_processedData'),
            ],
          ),
        ),
      ),
    );
  }
}