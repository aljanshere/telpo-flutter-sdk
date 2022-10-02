import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class WalkPaper extends PrintData {
  const WalkPaper({
    required int step,
  }) : super(type: PrintType.walkPaper, data: step);
}
