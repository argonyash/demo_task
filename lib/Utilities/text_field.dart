import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kriips_web/Utilities/sizeConstant.dart';

import 'color_constant.dart';

TextFormField getTextFormField(
    {TextEditingController? textEditingController,
    FormFieldValidator<String>? validation,
    TextInputType? textInputType,
    Function? ontap,
    double? size = 52,
    Widget? suffix,
    Widget? suffixIcon,
    bool textVisible = false,
    double? borderRadius,
    bool? isFillColor = false,
    Widget? prefixIcon,
    List<TextInputFormatter>? formator,
    bool isReadOnly = false,
    Function(String)? onChanged,
    bool enable = true,
    String? hintText,
    TextInputFormatter? formatter,
    String? labelText,
    FocusNode? focusNode,
    int? maxLine = 1}) {
  return TextFormField(
    controller: textEditingController,
    cursorColor: appTheme.primaryTheme,
    readOnly: isReadOnly,
    focusNode: focusNode,
    obscureText: textVisible,
    enabled: enable,
    inputFormatters: formator,
    validator: validation,
    onChanged: onChanged,
    keyboardType: textInputType,
    maxLines: maxLine,
    textCapitalization: TextCapitalization.characters,
    decoration: InputDecoration(
      filled: isFillColor,

      // helperText: "test",
      labelText: labelText,
      fillColor: appTheme.fillColor,
      labelStyle: TextStyle(
          fontFamily: "Poppins",
          color: (isNullEmptyOrFalse(focusNode)
              ? appTheme.primaryTheme
              : (focusNode!.hasFocus)
                  ? appTheme.primaryTheme
                  : appTheme.primaryTheme)),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appTheme.borderColor),
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
      ),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.borderColor),
          borderRadius: BorderRadius.circular(
              (borderRadius == null) ? MySize.size10! : borderRadius)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
        borderSide: BorderSide(color: appTheme.borderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.size10! : borderRadius),
      ),
      contentPadding: EdgeInsets.only(
        left: MySize.size20!,
        right: MySize.size10!,
        bottom: size! / 2, // HERE THE IMPORTANT PART
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      floatingLabelStyle: TextStyle(
          fontSize: MySize.size16!,
          fontFamily: "Poppins",
          color: (appTheme.primaryTheme)),
      helperStyle: TextStyle(
        fontSize: MySize.size16!,
        fontFamily: "Poppins",
      ),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: MySize.size16!, fontFamily: "Poppins"),
    ),
    style: TextStyle(fontSize: MySize.size16!, fontFamily: "Poppins"),
  );
}
