import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'telpo_sdk_flutter_platform_interface.dart';

/// An implementation of [TelpoSdkFlutterPlatform] that uses method channels.
class MethodChannelTelpoSdkFlutter extends TelpoSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('telpo_sdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
