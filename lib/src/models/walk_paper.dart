import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';

class WalkPaper extends PrintData {
  const WalkPaper({
    required int step,
  }) : super(type: PrintType.walkPaper, data: step);
}
