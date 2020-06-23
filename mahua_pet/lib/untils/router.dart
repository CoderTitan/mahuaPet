import 'package:flutter/material.dart';

import 'package:mahua_pet/pages/main/main_page.dart';

// 登录
import 'package:mahua_pet/pages/login/login.dart';
import 'package:mahua_pet/pages/login/register.dart';
import 'package:mahua_pet/pages/login/password_login.dart';


class TKRoute {
  // 初始路由
  static final String initialRoute = MainPage.routerName;

  // 路由列表
  static final Map<String, WidgetBuilder> routeList = {
    MainPage.routerName: (ctx) => MainPage(),

    // 登录
    LoginPage.rooteName: (ctx) => LoginPage(),
    RegisterPage.rooteName: (ctx) => RegisterPage(),
    PasswordPage.rooteName: (ctx) => PasswordPage()
  };

  // 自行扩展的
  static final RouteFactory generateRoute = (setting) {
    // if (setting.name == FilterScreen.routeName) {
    //   // 从底部弹出
    //   return MaterialPageRoute(
    //     builder: (context) => FilterScreen(),
    //     fullscreenDialog: true
    //   );
    // }
    return null;
  };

  static final RouteFactory unknownRoute = (setting) {
    return null;
  };
}