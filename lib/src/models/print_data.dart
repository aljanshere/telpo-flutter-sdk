import 'package:telpo_sdk_flutter/telpo_sdk_flutter.dart';

class PrintData<T> {
  final T data;
  final PrintType type;
  final double? width;
  final double? height;
  final PrintAlignment? alignment;
  final PrintedFontSize? fontSize;

  const PrintData({
    required this.type,
    required this.data,
    this.width,
    this.height,
    this.alignment,
    this.fontSize,
  });

  Map<String, dynamic> toJson() => {
    "data": data,
    "width": width,
    "height": height,
    "alignment": alignment?.name,
    "type": type.name,
    "fontSize": fontSize?.name,
  };

  @override
  String toString() {
    return 'PrintModel(data: $data, width: $width, height: $height, alignment: $alignment, type: $type, fontSize: $fontSize)';
  }
}
