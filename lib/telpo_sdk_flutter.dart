
import 'telpo_sdk_flutter_platform_interface.dart';

class TelpoSdkFlutter {
  Future<String?> getPlatformVersion() {
    return TelpoSdkFlutterPlatform.instance.getPlatformVersion();
  }
}
