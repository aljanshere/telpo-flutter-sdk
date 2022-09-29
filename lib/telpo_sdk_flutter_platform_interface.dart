import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'telpo_sdk_flutter_method_channel.dart';

abstract class TelpoSdkFlutterPlatform extends PlatformInterface {
  /// Constructs a TelpoSdkFlutterPlatform.
  TelpoSdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TelpoSdkFlutterPlatform _instance = MethodChannelTelpoSdkFlutter();

  /// The default instance of [TelpoSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTelpoSdkFlutter].
  static TelpoSdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TelpoSdkFlutterPlatform] when
  /// they register themselves.
  static set instance(TelpoSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
