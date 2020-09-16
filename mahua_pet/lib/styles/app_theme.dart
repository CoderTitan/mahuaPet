import 'package:flutter/material.dart';

import 'app_colors.dart';

class TKTheme {

  // 1. 共有属性
  static const double headline1 = 20;
  static const double headline2 = 30;
  static const double headline3 = 40;
  static const double headline4 = 24;
  static const double headline5 = 16;
  static const double headline6 = 27;

  static const double subtitle1 = 17;
  static const double subtitle2 = 13;
  static const double bodyText1 = 16;
  static const double bodyText2 = 13;
  static const double button = 16;
  static const double overline = 13;


  /// app主题配置
  static ThemeData appTheme({bool isNight = false, MaterialColor color = TKColor.main_color}) => ThemeData(
    primarySwatch: color,
    splashColor: Colors.transparent,
    canvasColor: TKColor.backColor(isNight),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: headline1),
      headline2: TextStyle(fontSize: headline2),
      headline3: TextStyle(fontSize: headline3),
      headline4: TextStyle(fontSize: headline4),
      headline5: TextStyle(fontSize: headline5),
      headline6: TextStyle(fontSize: headline6),
      subtitle1: TextStyle(fontSize: subtitle1),
      subtitle2: TextStyle(fontSize: subtitle2),
      bodyText1: TextStyle(fontSize: bodyText1),
      bodyText2: TextStyle(fontSize: bodyText2),
      button: TextStyle(fontSize: button),
      overline: TextStyle(fontSize: overline),
    ),
  );

}