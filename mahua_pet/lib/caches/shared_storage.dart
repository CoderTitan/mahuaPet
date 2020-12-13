/**
 * 用于保存临时缓存的配置信息
 */
import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:mahua_pet/utils/func_utils.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/providered/model/model_index.dart';
import 'shared_util.dart';
import 'shared_constant.dart';
import 'data_result.dart';


class SharedStorage {
  
  static ConfigInfo configInfo = ConfigInfo();
  static LoginInfo loginInfo = LoginInfo();
  static UserData userData = UserData();
  static DeviceInfoModel deviceInfo = DeviceInfoModel();
  static PetModel petModel = PetModel();
  
  static int currentPetId = 0;
  static bool showWelcome = false;


  //初始化全局信息，会在APP启动时执行
  static Future initStorage() async {
    showWelcome = await SharedUtils.getBool(ShareConstant.welcomePage);
  }

    /// 初始化用户信息
  static Future<DataResult> initUserInfo(Store store) async {
    // 用户配置
    DataResult config = await getConfigInfoLocal();
    if (config != null && config.result) {
      configInfo = config.data;
      store.dispatch(UpdateConfigInfo(config.data));
    }

    // 用户登录
    DataResult login = await getLoginInfoLocal();
    if (login != null && login.result) {
      loginInfo = login.data;
      bool isLogin = loginInfo.userId != null && loginInfo.userId > 0 && loginInfo.token != null && loginInfo.token.length > 0;
      store.dispatch(UpdateLoginInfo(login.data));
      store.dispatch(LoginStatusAction(isLogin));
    }

    // 用户信息
    DataResult userInfo = await getUserInfoLocal();
    if (userInfo != null && userInfo.result) {
      userData = userInfo.data;
      store.dispatch(UpdateUserInfo(userInfo.data));
    }

    // 宠物信息
    DataResult petInfo = await getCurrentModel();
    if (petInfo != null && petInfo.result) {
      petModel = petInfo.data;
      store.dispatch(UpdateCurrentPet(petInfo.data));
    }

    // 设备信息
    DataResult device = await getDeviceInfoLocal();
    if (device != null && device.result) {
      deviceInfo = device.data;
      store.dispatch(UpdateDeviceInfo(device.data));
    }

    // 主题信息
    int themeIndex = await SharedUtils.getInt(ShareConstant.themeColorIndex);
    if (themeIndex != null) {
      FuncUtils.setThemeData(store, themeIndex);
    }

    // 语言
    int localeIndex = await SharedUtils.getInt(ShareConstant.localIndex);
    if (localeIndex != null) {
      FuncUtils.changeLocale(store, localeIndex);
    } else {
      FuncUtils.curLocale = store.state.platformLocale;
      store.dispatch(RefreshLocaleAction(store.state.platformLocale));
    }

    return DataResult(userInfo.data, (userInfo.result && login.result));
  }

  /// 清除缓存信息
  static clearAll(Store store) async {
    configInfo = ConfigInfo();
    SharedUtils.remove(ShareConstant.configInfo);
    store.dispatch(UpdateConfigInfo(ConfigInfo()));

    loginInfo = LoginInfo();
    SharedUtils.remove(ShareConstant.loginInfo);
    store.dispatch(UpdateLoginInfo(LoginInfo()));

    userData = UserData();
    SharedUtils.remove(ShareConstant.userData);
    store.dispatch(UpdateUserInfo(UserData()));
  }

  /// 获取本地用户配置信息
  static getConfigInfoLocal() async {
    var _configInfo = await SharedUtils.getString(ShareConstant.configInfo);

    if (_configInfo != null && _configInfo != '') {
      var dataInfo = json.decode(_configInfo);
      ConfigInfo data = ConfigInfo.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /// 获取本地用户登录信息
  static getLoginInfoLocal() async {
    var _loginInfo = await SharedUtils.getString(ShareConstant.loginInfo);

    if (_loginInfo != null && _loginInfo != '') {
      var dataInfo = json.decode(_loginInfo);
      LoginInfo data = LoginInfo.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /// 获取本地用户登录信息
  static getUserInfoLocal() async {
    var _userData = await SharedUtils.getString(ShareConstant.userData);

    if (_userData != null && _userData != '') {
      var dataInfo = json.decode(_userData);
      UserData data = UserData.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /// 获取当前信息
  static getCurrentModel() async {
    var _petModel = await SharedUtils.getString(ShareConstant.petModel);

    if (_petModel != null && _petModel != '') {
      var jsonData = json.decode(_petModel);
      PetModel data = PetModel.fromJson(jsonData);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /// 获取本地用户设备信息
  static getDeviceInfoLocal() async {
    var _deviceInfo = await SharedUtils.getString(ShareConstant.deviceInfo);

    if (_deviceInfo != null && _deviceInfo != '') {
      var dataInfo = json.decode(_deviceInfo);
      DeviceInfoModel data = DeviceInfoModel.fromJson(dataInfo);
      return new DataResult(data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  // 持久化UserData信息
  static saveDeviceInfo() {
    SharedUtils.setString("deviceInfo", jsonEncode(deviceInfo?.toJson()));
  }

  /// 缓存showWelcome
  static saveShowWelcome() {
    SharedUtils.setBool(ShareConstant.welcomePage, true);
  }
}