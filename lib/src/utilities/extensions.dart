import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

extension ListX on List<PrintData> {
  List<Map<String, dynamic>?> toJson() {
    List<Map<String, dynamic>?> printData = [];

    for (final data in this) {
      printData.add(data.toJson());
    }

    return printData;
  }
}
