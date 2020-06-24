import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeUtil {

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static getColorFromTheme(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    Color primaryColor = Theme.of(context).primaryColor;
    Color cardColor = Theme.of(context).cardColor;
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    Color shawDowColor = isDark ? Color(0xFF000000) : Color(0xFFEEEEEE);
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle subTextStyle = Theme.of(context).textTheme.subtitle1;
    return {
      isDark: isDark,
      primaryColor: primaryColor,
      cardColor: cardColor,
      bgColor: bgColor,
      shawDowColor: shawDowColor,
      textStyle: textStyle,
      subTextStyle: subTextStyle
    };
  }

  static Color getDarkColor(Color color) {
    int number = 20;
    int red = color.red - number <= 0 ? color.red : color.red - number;
    int green = color.green - number <= 0 ? color.green : color.green - number;
    int blue = color.blue - number <= 0 ? color.blue : color.blue - number;
    return Color.fromRGBO(red, green, blue, 1);
  }

  static Color getLightColor(Color color) {
    int number = 30;
    int red = color.red + number >= 255 ? color.red : color.red + number;
    int green =
        color.green + number >= 255 ? color.green : color.green + number;
    int blue = color.blue + number >= 255 ? color.blue : color.blue + number;
    return Color.fromRGBO(red, green, blue, 1);
  }
}