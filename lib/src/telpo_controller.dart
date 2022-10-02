import 'package:flutter/services.dart';
import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';

class TelpoController {
  late MethodChannel _platform;

  final String _channelName = 'me.aljan.telpo_sdk_flutter/telpo';

  TelpoController() {
    _platform = MethodChannel(_channelName);
  }

  Future<String?> checkStatus() {
    return _platform.invokeMethod('checkStatus');
  }

  Future<bool?> connect() {
    return _platform.invokeMethod('connect');
  }

  Future<bool?> disconnect() {
    return _platform.invokeMethod('disconnect');
  }

  Future<bool?> isConnected() {
    return _platform.invokeMethod('isConnected');
  }

  Future<bool?> print(List<PrintData> data) {
    return _platform.invokeMethod('print', {"data": data.toJson()});
  }
}
