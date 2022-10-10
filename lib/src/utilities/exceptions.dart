class NoPaperException implements Exception {}

class LowBatteryException implements Exception {}

class OverHeatException implements Exception {}

class DeviceTransmitDataException implements Exception {}

class UnknownTelpoException implements Exception {
  const UnknownTelpoException([dynamic message]);
}
