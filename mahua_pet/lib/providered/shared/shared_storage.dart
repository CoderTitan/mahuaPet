
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_index.dart';


class SharedStorage {
  
  static SharedPreferences _prefs;
  static ConfigInfo configInfo = ConfigInfo();
  static LoginInfo loginInfo = LoginInfo();
  static UserData userData = UserData();


  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    print(_prefs);

    // 获取对应的json字符串
    var _configInfo = _prefs.getString('configInfo');
    var _loginInfo = _prefs.getString('loginInfo');
    var _userData = _prefs.getString('userData');

    if (_configInfo != null && _configInfo != 'null') {
      try {
        configInfo = ConfigInfo.fromJson(jsonDecode(_configInfo));
        print('configInfo = ${configInfo.toJson()}');
      } catch (error) {
        print('SharedStorage - configInfo, error = $error');
      }
    } 
    if (_loginInfo != null && _loginInfo != 'null') {
      try {
        loginInfo = LoginInfo.fromJson(jsonDecode(_loginInfo));
        print('loginInfo = ${loginInfo.toJson()}');
      } catch (error) {
        print('SharedStorage - loginInfo, error = $error');
      }
    }
    if (_userData != null && _userData != 'null') {
      try {
        userData = UserData.fromJson(jsonDecode(_userData));
        print('userData = ${userData.toJson()}');
      } catch (error) {
        print('SharedStorage - userData, error = $error');
      }
    }
  }

  // 持久化ConfigInfo信息
  static saveConfigInfo() {
    _prefs.setString("configInfo", jsonEncode(configInfo?.toJson()));
  }
      

  // 持久化LoginInfo信息
  static saveLoginInfo() {
    _prefs.setString("loginInfo", jsonEncode(loginInfo?.toJson()));
  }
      

  // 持久化UserData信息
  static saveUserData() {
    _prefs.setString("userData", jsonEncode(userData?.toJson()));
  }
}