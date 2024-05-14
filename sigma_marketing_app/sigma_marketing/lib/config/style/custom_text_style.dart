import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';

class CustomTextStyle {
  static TextStyle baseTextStyle(double fontSize, FontWeight fontWeight,
      [Color? color]) {
    return TextStyle(
      color: color ?? SMColors.white,
      fontSize: fontSize,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
    );
  }

  static TextStyle thinText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w100, color);
  }

  static TextStyle extraLightText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w200, color);
  }

  static TextStyle lightText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w300, color);
  }

  static TextStyle regularText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w400, color);
  }

  static TextStyle mediumText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w500, color);
  }

  static TextStyle semiBoldText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w600, color);
  }

  static TextStyle boldText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w700, color);
  }

  static TextStyle extraBoldText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w800, color);
  }

  static TextStyle blackText(double fontSize, [Color? color]) {
    return baseTextStyle(fontSize, FontWeight.w900, color);
  }
}
