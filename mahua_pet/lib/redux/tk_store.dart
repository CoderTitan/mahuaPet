import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'models/model_index.dart';
import 'reducer/reducer_index.dart';
import 'package:mahua_pet/providered/model/model_index.dart';

class TKState {

  /// 主题
  ThemeData themeData;
  /// 是否夜间模式: 黑色主题也是夜间模式
  bool isNightModal;

  /// 语言
  Locale locale;
  /// 当前手机平台默认语言
  Locale platformLocale;

  /// 是否登录
  bool isLogin;

  /// 登录注册获取用户信息
  ConfigInfo configInfo;
  LoginInfo loginInfo;
  UserData userData;
  DeviceInfoModel deviceInfo;

  /// 宠物列表
  List<PetModel> petList;
  PetModel currentPet;



  TKState({
    this.locale,
    this.themeData, 
    this.isNightModal,
    this.isLogin,
    this.loginInfo,
    this.configInfo,
    this.userData,
    this.deviceInfo,
    this.petList,
    this.currentPet,
  });
}

TKState appReducer(TKState state, action) {
  return TKState(
    /// 其他配置信息

    // appz主题
    themeData: ThemeDataReducer(state.themeData, action),
    isNightModal: NightModalReducer(state.isNightModal, action),
    locale: LocaleReducer(state.locale, action),

    // 登录
    isLogin: LoginReducer(state.isLogin, action),

    // 用户信息
    loginInfo: LoginInfoReducer(state.loginInfo, action),
    configInfo: ConfigInfoReducer(state.configInfo, action),
    userData: UserInfoModelReducer(state.userData, action),
    deviceInfo: DeviceInfoReducer(state.deviceInfo, action),

    // 宠物列表
    petList: PetListReducer(state.petList, action),
    currentPet: CurrentPetReducer(state.currentPet, action),
  );
}

final List<Middleware<TKState>> middleware = [
  LoginMiddleware(),
];