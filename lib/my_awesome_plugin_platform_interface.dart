import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_awesome_plugin_method_channel.dart';

abstract class MyAwesomePluginPlatform extends PlatformInterface {
  /// Constructs a MyAwesomePluginPlatform.
  MyAwesomePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyAwesomePluginPlatform _instance = MethodChannelMyAwesomePlugin();

  /// The default instance of [MyAwesomePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyAwesomePlugin].
  static MyAwesomePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyAwesomePluginPlatform] when
  /// they register themselves.
  static set instance(MyAwesomePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
