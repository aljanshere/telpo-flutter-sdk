import 'package:flutter/foundation.dart';
import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

/// Plain Old Dart Object representing printing data.
///
/// Types: [PrintData.text], [PrintData.byte], [PrintData.space]
class PrintData {
  final dynamic data;
  final PrintType type;
  final double? width;
  final double? height;
  final PrintAlignment? alignment;
  final PrintedFontSize? fontSize;

  /// [PrintData] can be initialized through factory constructors: text, byte, space.
  const PrintData._({
    required this.type,
    required this.data,
    this.width,
    this.height,
    this.alignment,
    this.fontSize,
  });

  /// PrintData from text. Optional alignment (PrintAlignment) and fontSize
  /// (PrintedFontSize) can be assigned for styling.
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

  /// PrintData for spacing, can be considered as [SizedBox] from Flutter
  /// Widgets.
  ///
  /// line property represents count of lines to be inserted.
  factory PrintData.space({required int line}) {
    return PrintData._(
      type: PrintType.walkPaper,
      data: line,
    );
  }

  /// PrintData from list of bytes where bytesList property can be comprised of
  /// one or multiple elements.
  factory PrintData.byte({
    required List<Uint8List?> bytesList,
    double? width,
    double? height,
    PrintAlignment? alignment,
    PrintedFontSize? fontSize,
  }) {
    return PrintData._(
      type: PrintType.byte,
      data: bytesList,
      width: width,
      height: height,
      alignment: alignment,
      fontSize: fontSize,
    );
  }

  /// Data is being transferred to the plugin as JSON.
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

  /// Stringifying [PrintData] object.
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
