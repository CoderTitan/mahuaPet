import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';

class TKCommonConfig {

  /// 所有主题色
  /// 索引为1的必须是黑色主题, 夜间模式默认索引为1
  static List<MaterialColor> getThemeColors() {
    return [
      TKColor.main_color,
      TKColor.black_color,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }
}