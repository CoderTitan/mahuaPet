import 'package:flutter/material.dart';

import 'models/model_index.dart';
import 'reducer/reducer_index.dart';
import 'package:mahua_pet/providered/model/model_index.dart';

class TKState {

  /// 我的用户信息
  UserInfoModel userInfo;

  /// 登录注册获取用户信息
  ConfigInfo configInfo;
  LoginInfo loginInfo;
  UserData userData;

  /// 宠物列表
  List<PetModel> petList;
  
  /// 主题
  ThemeData themeData;

  /// 是否夜间模式: 黑色主题也是夜间模式
  bool isNightModal;

  /// 语言
  Locale locale;

  /// 当前手机平台默认语言
  Locale platformLocale;

  /// 是否登录
  bool login;


  TKState({
    this.themeData, 
    this.isNightModal,
    this.userInfo,
    this.petList,
    this.locale
  });
}

TKState appReducer(TKState state, action) {
  return TKState(
    themeData: ThemeDataReducer(state.themeData, action),
    isNightModal: NightModalReducer(state.isNightModal, action),
    userInfo: UserInfoModelReducer(state.userInfo, action),
    petList: PetListReducer(state.petList, action),
  );
}