import 'package:flutter_test/flutter_test.dart';
import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';
import 'package:telpo_sdk_flutter/telpo_sdk_flutter_platform_interface.dart';
import 'package:telpo_sdk_flutter/telpo_sdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTelpoSdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TelpoSdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TelpoSdkFlutterPlatform initialPlatform = TelpoSdkFlutterPlatform.instance;

  test('$MethodChannelTelpoSdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTelpoSdkFlutter>());
  });

  test('getPlatformVersion', () async {
    TelpoSdkFlutter telpoSdkFlutterPlugin = TelpoSdkFlutter();
    MockTelpoSdkFlutterPlatform fakePlatform = MockTelpoSdkFlutterPlatform();
    TelpoSdkFlutterPlatform.instance = fakePlatform;

    expect(await telpoSdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
