
import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/config/http_refresh/point_request.dart';
import 'package:mahua_pet/providered/model/config_info.dart';
import 'package:mahua_pet/providered/model/model_index.dart';
import '../model/user_data.dart';
import '../shared/shared_storage.dart';

class UserProvider extends ChangeNotifier {

  bool get isLogin {
    if (loginInfo.token != null && loginInfo.token.length > 0 && loginInfo.userId > 0) {
      return true;
    }
    return false;
  }

  ConfigInfo get configInfo {
    return SharedStorage.configInfo;
  }

  LoginInfo get loginInfo {
    return SharedStorage.loginInfo;
  }
  
  UserData get userData {
    return SharedStorage.userData;
  }

  set configInfo(ConfigInfo configInfo) {
    SharedStorage.configInfo = configInfo;
    SharedStorage.saveConfigInfo();
    notifyListeners();
  }

  set loginInfo(LoginInfo loginInfo) {
    final lastLogin = SharedStorage.loginInfo;
    if (loginInfo?.userId != lastLogin?.userId) {
      SharedStorage.loginInfo?.lastUserId = loginInfo?.userId;
      SharedStorage.loginInfo = loginInfo;
    }
    SharedStorage.saveLoginInfo();
    notifyListeners();
  }

  set userData(UserData userData) {
    SharedStorage.userData = userData;
    SharedStorage.saveUserData();
    notifyListeners();
  } 

  // 相关构造方法
  UserProvider();

  UserProvider.config(
    String eventName, 
    String token, 
    int userId
  ) {
    PointRequest.eventBaseRequest(eventName, token, userId).then((value) {
      configInfo = value;
    });
  }

  UserProvider.user(int userId) {
    PointRequest.requestUser(userId).then((value) {
      userData = value;
    });
  }
}