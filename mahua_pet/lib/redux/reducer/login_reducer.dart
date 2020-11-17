import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../tk_store.dart';
import '../action/action_index.dart';


/************* 登录状态信息 *************/
/// 登录状态
final LoginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginStatusAction>(_loginResult),
  TypedReducer<bool, LogoutAction>(_logoutResult),
]);

bool _loginResult(bool result, LoginStatusAction action) {
  SharedUtils.setBool(ShareConstant.isLogin, action.status);
  return action.status;
}

bool _logoutResult(bool result, LogoutAction action) {
  return true;
}

class LoginStatusAction {
  final bool status;

  LoginStatusAction(this.status);
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}
/************* end *************/



/************* 登录状态信息 *************/
/// 
final LoginSuccessReducer = combineReducers<bool>([
  TypedReducer<bool, LoginStatusAction>(_loginSuccessResult),
]);

bool _loginSuccessResult(bool result, LoginStatusAction action) {
  SharedUtils.setBool(ShareConstant.isLogin, action.status);
  return action.status;
}

class LoginSuccessAction {
  final BuildContext context;
  final LoginInfo loginInfo;

  LoginSuccessAction(this.context, this.loginInfo);
}
/************* end *************/



class LoginMiddleware implements MiddlewareClass<TKState> {
  @override
  void call(Store<TKState> store, dynamic action, NextDispatcher next) {
    if (action is LogoutAction) {
      SharedUtils.setBool(ShareConstant.isLogin, false);
      SharedStorage.clearAll(store);
    }
    if (action is LoginSuccessAction) {
      store.dispatch(LoginStatusAction(true));
      
      LoginInfo loginInfo = action.loginInfo;
      SharedStorage.loginInfo = loginInfo;
      SharedUtils.setString(ShareConstant.loginInfo, jsonEncode(loginInfo?.toJson()));
      SharedUtils.setBool(ShareConstant.isLogin, true);
      FetchUserInfoAction.loadPetList(store);
      FetchUserInfoAction.loadUserData(store).then((value) {});
      
      PointRequest.eventBaseRequest('APP首页', loginInfo.token, loginInfo.userId).then((value) {});

      TKRoute.popToRoutePage(action.context);
      TKToast.showSuccess('登录成功');
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}