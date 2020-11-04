import 'package:flutter/material.dart';

class TKColor {
  

  static const white = Colors.white;
  static const black = Colors.black;

  // Color
  static const color_ffea9e = Color(0xFFffea9e);
  static const color_ffe277 = Color(0xFFffe277);
  static const color_ffea9e_33 = Color(0x33ffea9e);
  static const color_f5ca2b = Color(0xFFF5CA2B);
  static const color_ffb51b = Color(0xFFffb51b);
  static const color_ff9600 = Color(0xFFff9600);
  static const color_ff0000 = Color(0xFFff0000);
  static const color_ff4040 = Color(0xFFff4040);
  static const color_ec0000 = Color(0xFFec0000);
  static const color_79b7f7 = Color(0xFF79b7f7);
  static const color_05cb98 = Color(0xFF05cb98);
  static const color_0386ff = Color(0xFF0386ff);
  static const color_526e94 = Color(0xFF526e94);


  static const color_f7f7f7 = Color(0xFFf7f7f7);
  static const color_e5e5e5 = Color(0xFFe5e5e5);
  static const color_e8e8e8 = Color(0xFFe8e8e8);
  static const color_e1e1e1 = Color(0xFFe1e1e1);
  static const color_dedede = Color(0xFFdedede);
  static const color_cccccc = Color(0xFFcccccc);
  static const color_999999 = Color(0xFF999999);
  static const color_666666 = Color(0xFF666666);
  static const color_333333 = Color(0xFF333333);
  static const color_1a1a1a = Color(0xFF1a1a1a);
  static const color_808080 = Color(0xFF808080);
  static const color_4b4b4b = Color(0xFF4b4b4b);
  static const color_6f6f6f = Color(0xFF6f6f6f);
  static const color_b6b6b6 = Color(0xFFb6b6b6);

  static const color_eeeeee = Color(0xFFEEEEEE);
  static const color_2b364d = Color(0xFF2B364D);
  static const color_f1f1f1 = Color(0xFFF1F1F1);
  static const color_151b26 = Color(0xFF151B26);
  static const color_e7e9ea = Color(0xFFE7E9EA);
  static const color_abb0b7 = Color(0xFFABB0B7);
  static const color_7c848d = Color(0xFF7C848D);

  static const color_5d5d5d = Color(0xFF5D5D5D);
  static const color_edf2fa = Color(0xFFEDF2FA);
  static const color_868686 = Color(0xFF868686);
  static const color_a2acbf = Color(0xFFA2ACBF);
  static const color_c6c6c6 = Color(0xFFC6C6C6);
  static const color_424e66 = Color(0xFF424E66);

  /// 浅色背景
  static Color backColor(bool isNight) {
    return isNight ? color_151b26 : color_f7f7f7;
  }

  /// 背景颜色
  static Color whiteColor(bool isNight) {
    return isNight ? black_color : white;
  }

  /// 分隔线颜色
  static Color lineColor(bool isNight) {
    return isNight ? color_2b364d : color_eeeeee;
  }
    
  /// 间隙颜色
  static Color marginColor(bool isNight) {
    return isNight ? color_151b26 : color_f1f1f1;
  }
  
  /// 黑色字体颜色
  static Color blackColor(bool isNight) {
    return isNight ? color_edf2fa : color_5d5d5d;
  }

  /// 中浅色字体颜色
  static Color grayColor(bool isNight) {
    return isNight ? color_a2acbf : color_868686;
  }

  /// 浅色字体颜色
  static Color lightGray(bool isNight) {
    return isNight ? color_424e66 : color_c6c6c6;
  }

  /// 333333
  static Color font33(bool isNight) {
    return isNight ? color_e7e9ea : color_333333;
  }

  /// 333333
  static Color font66(bool isNight) {
    return isNight ? color_abb0b7 : color_666666;
  }

  /// 333333
  static Color font99(bool isNight) {
    return isNight ? color_7c848d : color_999999;
  }

  /// MaterialColor
  static const int _mainValue = 0xFFF5CA2B;
  static const int _blackValue = 0xFF19202D;

  static const MaterialColor main_color = MaterialColor(
    _mainValue,
    <int, Color>{
       25: Color(0xDDFFF3E0),
       50: Color(0xFFFFF3E0),
      100: Color(0xFFFFE0B2),
      200: Color(0xFFFFCC80),
      300: Color(0xFFFFB74D),
      400: Color(0xFFFFA726),
      500: Color(_mainValue),
      600: Color(0xFFFB8C00),
      700: Color(0xFFF57C00),
      800: Color(0xFFEF6C00),
      900: Color(0xFFE65100),
    },
  );

  static const MaterialColor black_color = MaterialColor(
    _blackValue,
    const <int, Color>{
      50: const Color(_blackValue),
      100: const Color(_blackValue),
      200: const Color(_blackValue),
      300: const Color(_blackValue),
      400: const Color(_blackValue),
      500: const Color(_blackValue),
      600: const Color(_blackValue),
      700: const Color(_blackValue),
      800: const Color(_blackValue),
      900: const Color(_blackValue),
    },
  );
}