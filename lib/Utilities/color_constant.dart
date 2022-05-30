import 'package:flutter/material.dart';

class BaseTheme {
  Color get primaryTheme => fromHex('#E60943');
  Color get whiteColor => Colors.white;
  Color get secondaryColor => fromHex('#FB869D');
  Color get GrayColor => fromHex('#707070');
  Color get textGrayColor => fromHex('#BFBFBF');
  Color get borderColor => fromHex('#B8B8B8');
  Color get fillColor => fromHex('#F5F5F5');
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
