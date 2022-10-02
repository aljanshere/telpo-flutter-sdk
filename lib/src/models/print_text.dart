import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class PrintText extends PrintData {
  const PrintText({
    required String text,
    super.fontSize,
    super.alignment,
  }) : super(type: PrintType.text, data: text);
}
