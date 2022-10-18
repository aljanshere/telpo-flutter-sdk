import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

/// Utility element for inserting empty space on the sheet. Consider as [SizedBox]
/// from Flutter.
///
/// step parameter represents space-line count that will be inserted.
class WalkPaper extends PrintData {
  const WalkPaper({
    required int step,
  }) : super(type: PrintType.walkPaper, data: step);
}
