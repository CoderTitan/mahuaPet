import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:redux/redux.dart';
import 'package:provider/provider.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';

import 'package:mahua_pet/pages/home/view_model/pet_view_model.dart';
import 'package:mahua_pet/pages/login/login.dart';

import 'route_util.dart';


class FuncUtils {

  /// 当前语言
  static Locale curLocale;

  // 是否登录
  static bool isLogin() {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    if (loginInfo.userId != null && loginInfo.userId > 0) {
      return true;
    }
    return false;
  }

  // 跳转登录页面
  static void jumpLogin(BuildContext context) {
    Navigator.of(context).pushNamed(LoginPage.routeName, arguments: '/');
  }

  // 退出登录
  static void loginOut(BuildContext context) {
    UserProvider userModel = Provider.of<UserProvider>(context, listen: false);
    LoginInfo loginInfo = userModel.loginInfo;
    loginInfo.userId = 0;
    userModel.loginInfo = loginInfo;

    PetViewModel petVM = Provider.of<PetViewModel>(context, listen: false);
    petVM.petList = [];

    TKToast.showSuccess('退出登录成功');
    TKRoute.popRoot(context);
  }

  // 退出登录
  static void loginOutAction(BuildContext context) {
    Store<TKState> store = StoreProvider.of(context);

    store.dispatch(LogoutAction(context));
    store.dispatch(LoginStatusAction(false));
    store.dispatch(UpdatePetList([]));
    store.dispatch(UpdateCurrentPet(PetModel()));

    TKToast.showSuccess('退出登录成功');
    TKRoute.popRoot(context);
  }

  // 格式化手机号, 添加空格
  static String formatPhone(account) {
    String phoneStr = account.toString().replaceAll(' ', '');
    if (phoneStr.length > 7 && phoneStr.length <= 11) {
      phoneStr = phoneStr.substring(0, 7) + ' ' + phoneStr.substring(7);
      phoneStr = phoneStr.substring(0, 3) + ' ' + phoneStr.substring(3);
    }
    if (phoneStr.length > 3 && phoneStr.length < 8) {
      phoneStr = phoneStr.substring(0, 3) + ' ' + phoneStr.substring(3);
    }
    return phoneStr;
  }

  // 手机号去除空格
  static String getPhone(account) {
    return account.toString().replaceAll(' ', '');
  }

  // 判断手机号是否符合规则
  static bool isPhoneNumber(account) {
    // 手机段：134,135,136,137,138,139,147,148[卫星通信],150,151,152,157,158,159,172,178,182,183,184,187,188,198
    final isChinaMobile = new RegExp(r'^(1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|98)\d{8}$)');// 中国移动
		// 手机段：130,131,132,145,146[卫星通信],155,156,166,171,175,176,185,186
		final isChinaUnicom = new RegExp(r'^(1(3[0-2]|4[56]|5[56]|66|7[156]|8[56])\d{8}$)');// 中国联通
		// 手机段：133,149,153,173,174,177,180,181,189,199
		final isChinaTelcom = new RegExp(r'^(1(33|49|53|7[347]|8[019]|99)\d{8}$)');// 中国电信
		final isOtherTelphone = new RegExp(r'^(170\\d{8}$)');

    if (isChinaMobile.hasMatch(account)) {
      return true;
    } else if (isChinaUnicom.hasMatch(account)) {
      return true;
    } else if (isChinaTelcom.hasMatch(account)) {
      return true;
    } 
    return isOtherTelphone.hasMatch(account);
  }

  /// 设置当前主题
  static setThemeData(Store store, int index) {
    ThemeData themeData = getThemeData(index);
    store.dispatch(RefreshThemeDataAction(themeData));
    store.dispatch(RefreshNightModalAction(index == 1));
  } 
  
  /// 获取当前主题
  static getThemeData(int index) {
    List<MaterialColor> colorList = TKCommonConfig.getThemeColors();
    return TKTheme.appTheme(isNight: index == 1, color: colorList[index]);
  }

  /// 获取当前主题
  static initThemeData(Store store) async {
    ///读取主题
    int themeIndex = await SharedUtils.getInt(ShareConstant.themeColorIndex);
    if (themeIndex != null) {
      setThemeData(store, themeIndex);
    }
  }

  /// 切换语言
  static changeLocale(Store store, int index) {
    Locale locale = store.state.platformLocale;
    switch (index) {
      case 0:
        // locale = Locale('zh', 'CH');
        locale = Locale.fromSubtags(languageCode: 'zh');
        break;
      case 1:
        // locale = Locale('en', 'US');
        locale = Locale.fromSubtags(languageCode: 'en');
        break;
      case 2:
        locale = Locale.fromSubtags(languageCode: 'ko');
        break;
    }
    curLocale = locale;
    store.dispatch(RefreshLocaleAction(locale));
  }


  /// 字符串补0
  static String fillInt(int number) {
    if (number < 10) {
      return '0$number';
    }
    return '$number';
  }
}