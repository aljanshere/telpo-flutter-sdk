import 'package:flutter/services.dart';
import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class TelpoController {
  late MethodChannel _platform;

  final String _channelName = 'me.aljan.telpo_flutter_sdk/telpo';

  TelpoController() {
    _platform = MethodChannel(_channelName);
  }

  // TODO: aljan what are the statuses?
  Future<String?> checkStatus() {
    return _platform.invokeMethod('checkStatus');
  }

  /// Connect with underlying Telpo device if any.
  ///
  /// Returns a nullable [bool] whether connected successfully or not.
  Future<bool?> connect() {
    return _platform.invokeMethod('connect');
  }

  /// Disconnect from Telpo device.
  ///
  /// Returns a nullable [bool] whether disconnected successfully or not.
  Future<bool?> disconnect() {
    return _platform.invokeMethod('disconnect');
  }

  /// Returns a nullable [bool] whether or not connected with Telpo device.
  Future<bool?> isConnected() {
    return _platform.invokeMethod('isConnected');
  }

  Future<bool?> print(List<PrintData> data) {
    return _platform.invokeMethod(
      'print',
      {
        "data": data.toJson(),
      },
    );
  }
}
