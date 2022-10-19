import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

/// [Enum] representing printable element type.
enum _PrintDataType { byte, text, space }

/// Plain Old Dart Object representing printing data.
///
/// Types: [PrintData.text], [PrintData.byte], [PrintData.space]
class PrintData {
  final dynamic _data;
  final double? _width;
  final double? _height;
  final PrintAlignment? _alignment;
  final PrintedFontSize? _fontSize;

  final _PrintDataType _type;

  /// [PrintData] can be initialized through factory constructors: text, byte, space.
  const PrintData._(
    this._type,
    this._data, [
    this._width,
    this._height,
    this._alignment,
    this._fontSize,
  ]);

  /// PrintData from text. Optional alignment (PrintAlignment) and fontSize
  /// (PrintedFontSize) can be assigned for styling.
  factory PrintData.text(
    String text, {
    PrintAlignment? alignment,
    PrintedFontSize? fontSize,
  }) {
    return PrintData._(
      _PrintDataType.text,
      text,
      null,
      null,
      alignment,
      fontSize,
    );
  }

  /// PrintData for spacing, can be considered as [SizedBox] from Flutter
  /// Widgets.
  ///
  /// line property represents count of lines to be inserted.
  factory PrintData.space({required int line}) {
    return PrintData._(_PrintDataType.space, line);
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
      _PrintDataType.byte,
      bytesList,
      width,
      height,
      alignment,
      fontSize,
    );
  }

  /// Data is being transferred to the plugin as JSON.
  Map<String, dynamic> toJson() {
    return {
      "data": _data,
      "width": _width,
      "height": _height,
      "alignment": _alignment?.name,
      "type": _type.name,
      "fontSize": _fontSize?.name,
    };
  }

  /// Stringifying [PrintData] object.
  @override
  String toString() {
    return '''PrintModel(
      data: $_data,
      width: $_width,
      height: $_height,
      alignment: $_alignment
      type: $_type,
      fontSize: $_fontSize)''';
  }
}
