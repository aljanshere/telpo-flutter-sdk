/// [Enum] representing alignment of [PrintData.text] element.
enum PrintAlignment {
  /// Left
  left,

  /// Center
  center,

  /// Right
  right,
}

/// [Enum] representing sizes of [PrintData.text] element.
enum PrintedFontSize {
  size18,
  size24,
  size34,
  size44,
  size54,
  size64,
}

/// [Enum] representing status of underlying Telpo device.
enum TelpoStatus {
  /// OK, meaning able to print.
  ok,

  /// No paper left on device.
  noPaper,

  /// Device is overheated.
  overHeat,

  /// Device cache is full, (@mrjnlcn what does that mean?)
  cacheIsFull,

  /// Any other unknown and undocumented status.
  unknown,
}

/// [Enum] representing result of printing action.
enum PrintResult {
  /// Printed successfully.
  success,

  /// Printed aborted since there is no paper left.
  noPaper,

  /// Printed aborted due to insufficient battery.
  lowBattery,

  /// Printed aborted since the device is overheated.
  overHeat,

  /// Printed aborted since device is not ready for the action (weird, right?).
  dataCanNotBeTransmitted,

  /// Printed aborted because of undocumented and unexpected reason.
  other,
}
