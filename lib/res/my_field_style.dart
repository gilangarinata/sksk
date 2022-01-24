import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_colors.dart';

class MyFieldStyle {
  static TextStyle myFieldStylePrimary() {
    TextStyle textStyle =
        TextStyle(color: MyColors.grey_80, height: 1.4, fontSize: 16);
    return textStyle;
  }

  static TextStyle myFieldLabelStylePrimary() {
    TextStyle labelStyle = TextStyle(
        color: MyColors.grey_80, fontSize: 14, fontWeight: FontWeight.bold);
    return labelStyle;
  }

  static UnderlineInputBorder myUnderlineFieldStyle() {
    UnderlineInputBorder lineStyle = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.accentDark, width: 1));
    return lineStyle;
  }

  static UnderlineInputBorder myUnderlineFocusFieldStyle() {
    UnderlineInputBorder lineStyle = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.accentDark, width: 2));
    return lineStyle;
  }
}
