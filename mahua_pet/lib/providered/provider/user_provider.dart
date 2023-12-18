import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/config/http_refresh/point_request.dart';
import 'package:mahua_pet/providered/model/model_index.dart';

class UserProvider extends ChangeNotifier {
  bool get isLogin {
    final tokenLength = loginInfo.token?.length ?? 0;
    final userId = loginInfo.userId ?? 0;
    if (loginInfo.token != null && tokenLength > 0 && userId > 0) {
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
    notifyListeners();
  }

  set loginInfo(LoginInfo loginInfo) {
    final lastLogin = SharedStorage.loginInfo;
    final userId = loginInfo.userId ?? 0;
    if (loginInfo.userId != lastLogin.userId) {
      SharedStorage.loginInfo.lastUserId = userId;
      SharedStorage.loginInfo = loginInfo;
    }
    notifyListeners();
  }

  set userData(UserData userData) {
    SharedStorage.userData = userData;
    notifyListeners();
  }

  // 相关构造方法
  UserProvider();

  UserProvider.config(String eventName, String token, int userId) {
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
