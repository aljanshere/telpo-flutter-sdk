import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telpo_sdk_flutter/telpo_sdk_flutter_method_channel.dart';

void main() {
  MethodChannelTelpoSdkFlutter platform = MethodChannelTelpoSdkFlutter();
  const MethodChannel channel = MethodChannel('telpo_sdk_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
