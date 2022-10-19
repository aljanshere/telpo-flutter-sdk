import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class TelpoPrintSheet {
  final _elements = <PrintData>[];

  void addElement(PrintData element) => _elements.add(element);
  void addElements(List<PrintData> element) => _elements.addAll(element);
  void removeAll() => _elements.clear();

  int get elementsCount => _elements.length;

  List<Map<String, dynamic>?> get asJson {
    return _elements.map((e) => e.toJson()).toList();
  }
}
