import 'package:flutter_test/flutter_test.dart';
import 'package:my_awesome_plugin/my_awesome_plugin.dart';
import 'package:my_awesome_plugin/my_awesome_plugin_platform_interface.dart';
import 'package:my_awesome_plugin/my_awesome_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyAwesomePluginPlatform
    with MockPlatformInterfaceMixin
    implements MyAwesomePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyAwesomePluginPlatform initialPlatform = MyAwesomePluginPlatform.instance;

  test('$MethodChannelMyAwesomePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyAwesomePlugin>());
  });

  test('getPlatformVersion', () async {
    MyAwesomePlugin myAwesomePlugin = MyAwesomePlugin();
    MockMyAwesomePluginPlatform fakePlatform = MockMyAwesomePluginPlatform();
    MyAwesomePluginPlatform.instance = fakePlatform;

    expect(await myAwesomePlugin.getPlatformVersion(), '42');
  });
}
