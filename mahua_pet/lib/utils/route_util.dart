import 'package:flutter/material.dart';

import 'package:mahua_pet/pages/welcome/welcome_page.dart';
import 'package:mahua_pet/pages/welcome/launch_page.dart';
import 'package:mahua_pet/pages/main/main_page.dart';

// 登录
import 'package:mahua_pet/pages/login/login.dart';
import 'package:mahua_pet/pages/login/register.dart';
import 'package:mahua_pet/pages/login/password_login.dart';

// 首页相关模块
import 'package:mahua_pet/pages/home/contents/calendar_page.dart';
import 'package:mahua_pet/pages/home/contents/pet_list.dart';

// 发现相关模块



class TKRoute {
  // 初始路由
  static final String welcomeRoute = WelcomePage.routerName;
  static final String launchRoute = LaunchPage.routerName;
  static final String initialRoute = MainPage.routerName;

  // 路由列表
  static final Map<String, WidgetBuilder> routeList = {
    // 启动页和引导页
    WelcomePage.routerName: (ctx) => WelcomePage(),
    LaunchPage.routerName: (ctx) => LaunchPage(),

    // 主路由
    MainPage.routerName: (ctx) => MainPage(),

    // 登录
    LoginPage.routeName: (ctx) => LoginPage(),
    RegisterPage.routeName: (ctx) => RegisterPage(),
    PasswordPage.routeName: (ctx) => PasswordPage(),
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


  /// 图片浏览器方式
  static pushImagePreview(BuildContext context, Widget pageRoute) {
    Navigator.of(context).push(PageRouteBuilder(
      // transitionDuration: Duration(seconds: 1),
      pageBuilder: (ctx, animal1, animal2) {
        return FadeTransition(opacity: animal1, child: pageRoute);
      }
    ));
  }

  /// push
  static push(BuildContext context, Widget pageRoute, {RouteSettings settings}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => pageRoute,
      settings: settings
    ));
  }

  /// 跳转到main
  static pushMainRoot(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainPage.routerName);
  }

  /// 返回到根路由
  static popRoot(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  /// 登录返回到指定路由
  static popToRoutePage(BuildContext context) {
    final routeName = ModalRoute.of(context).settings.arguments;
    if (routeName == '/') {
      popRoot(context);
    } else {
      Navigator.of(context).popUntil(routeName);
    }
  }
}