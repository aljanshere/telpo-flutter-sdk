import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';

class PrintText extends PrintData {
  const PrintText({
    required String text,
    super.fontSize,
    super.alignment,
  }) : super(type: PrintType.text, data: text);
}
