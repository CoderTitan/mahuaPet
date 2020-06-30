import 'package:flutter/material.dart';

import 'package:mahua_pet/pages/main/main_page.dart';

// 登录
import 'package:mahua_pet/pages/login/login.dart';
import 'package:mahua_pet/pages/login/register.dart';
import 'package:mahua_pet/pages/login/password_login.dart';

// 首页相关模块
import 'package:mahua_pet/pages/home/contents/calendar_page.dart';
import 'package:mahua_pet/pages/home/contents/pet_add.dart';
import 'package:mahua_pet/pages/home/contents/pet_list.dart';

import 'package:mahua_pet/pages/discover/find_page.dart';



class TKRoute {
  // 初始路由
  static final String initialRoute = MainPage.routerName;

  // 路由列表
  static final Map<String, WidgetBuilder> routeList = {
    MainPage.routerName: (ctx) => MainPage(),

    // 登录
    LoginPage.routeName: (ctx) => LoginPage(),
    RegisterPage.routeName: (ctx) => RegisterPage(),
    PasswordPage.routeName: (ctx) => PasswordPage(),

    // 首页相关模块
    CalendarPage.routeName: (ctx) => CalendarPage(),
    PetAddPage.routeName: (ctx) => PetAddPage(),
    PetListPage.routeName: (ctx) => PetListPage(),


    FindPage.routeName: (ctx) => FindPage(''),
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



  // 返回到根路由
  static popRoot(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  // 登录返回到指定路由
  static popToRoutePage(BuildContext context) {
    final routeName = ModalRoute.of(context).settings.arguments;
    if (routeName == '/') {
      popRoot(context);
    } else {
      Navigator.of(context).popUntil(routeName);
    }
  }
}