import 'package:flutter/material.dart';
import 'package:kriips_web/Utilities/sizeConstant.dart';

import 'color_constant.dart';

Container button({
  double height = 50,
  double width = 341,
  String? title = "",
  Color? backgroundColor,
  Color? borderColor,
  Color? textColor,
  Widget? widget,
  FontWeight fontWeight = FontWeight.bold,
  double? fontsize = 14,
}) {
  return Container(
    height: MySize.getScaledSizeHeight(height),
    width: MySize.getScaledSizeWidth(width),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(MySize.size6!),
      border: Border.all(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: 1),
      color:
          (backgroundColor == null) ? appTheme.primaryTheme : backgroundColor,
    ),
    alignment: Alignment.center,
    child: (widget != null)
        ? Center(child: widget)
        : Text(
            title!,
            style: TextStyle(
                color: (textColor == null) ? Colors.white : textColor,
                fontWeight: fontWeight,
                fontSize: MySize.getScaledSizeHeight(fontsize!)),
          ),
  );
}
