import 'package:flutter/foundation.dart';
import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

class PrintData {
  final dynamic data;
  final PrintType type;
  final double? width;
  final double? height;
  final PrintAlignment? alignment;
  final PrintedFontSize? fontSize;

  const PrintData._({
    required this.type,
    required this.data,
    this.width,
    this.height,
    this.alignment,
    this.fontSize,
  });

  factory PrintData.text(
    String text, {
    PrintAlignment? alignment,
    PrintedFontSize? fontSize,
  }) {
    return PrintData._(
      type: PrintType.text,
      data: text,
      alignment: alignment,
      fontSize: fontSize,
    );
  }

  factory PrintData.space({required int line}) {
    return PrintData._(
      type: PrintType.walkPaper,
      data: line,
    );
  }

  factory PrintData.byte({
    required List<Uint8List?> bytes,
    double? width,
    double? height,
    PrintAlignment? alignment,
    PrintedFontSize? fontSize,
  }) {
    return PrintData._(
      type: PrintType.byte,
      data: bytes,
      width: width,
      height: height,
      alignment: alignment,
      fontSize: fontSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "width": width,
      "height": height,
      "alignment": alignment?.name,
      "type": type.name,
      "fontSize": fontSize?.name,
    };
  }

  @override
  String toString() {
    return '''PrintModel(
      data: $data,
      width: $width,
      height: $height,
      alignment: $alignment
      type: $type,
      fontSize: $fontSize)''';
  }
}
