import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';

extension ListX on List<PrintData> {
  List<Map<String, dynamic>?> toJson() {
    List<Map<String, dynamic>?> printData = [];

    for (final data in this) {
      printData.add(data.toJson());
    }

    return printData;
  }
}
