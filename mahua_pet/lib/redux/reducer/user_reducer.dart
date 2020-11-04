
import 'dart:convert';

import 'package:mahua_pet/providered/model/model_index.dart';
import 'package:redux/redux.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import '../models/model_index.dart';

// 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来

/************* 我的用户配置信息 *************/
/// 我的用户配置信息
final ConfigInfoReducer = combineReducers<ConfigInfo>([
  TypedReducer<ConfigInfo, UpdateConfigInfo>(_updateConfigLoaded)
]);

ConfigInfo _updateConfigLoaded(ConfigInfo configInfo, UpdateConfigInfo action) {
  configInfo = action.configInfo;
  SharedUtils.setString(ShareConstant.configInfo, jsonEncode(action.configInfo?.toJson()));
  return configInfo;
}

class UpdateConfigInfo {
  final ConfigInfo configInfo;

  UpdateConfigInfo(this.configInfo);
}
/************* end *************/



/************* 我的用户登录信息 *************/
/// 我的用户登录信息
final LoginInfoReducer = combineReducers<LoginInfo>([
  TypedReducer<LoginInfo, UpdateLoginInfo>(_updateLoginLoaded)
]);

LoginInfo _updateLoginLoaded(LoginInfo loginInfo, UpdateLoginInfo action) {
  loginInfo = action.loginInfo;
  SharedUtils.setString(ShareConstant.loginInfo, jsonEncode(action.loginInfo?.toJson()));
  return loginInfo;
}

class UpdateLoginInfo {
  final LoginInfo loginInfo;

  UpdateLoginInfo(this.loginInfo);
}
/************* end *************/



/************* 我的用户信息 *************/
/// 我的用户信息
final UserInfoModelReducer = combineReducers<UserData>([
  TypedReducer<UserData, UpdateUserInfo>(_updateLoaded)
]);

UserData _updateLoaded(UserData userInfo, UpdateUserInfo action) {
  userInfo = action.userInfo;
  SharedUtils.setString(ShareConstant.userData, jsonEncode(action.userInfo?.toJson()));
  return userInfo;
}

class UpdateUserInfo {
  final UserData userInfo;

  UpdateUserInfo(this.userInfo);
}
/************* end *************/


/************* 我的用户设备信息 *************/
/// 我的用户设备信息
final DeviceInfoReducer = combineReducers<DeviceInfoModel>([
  TypedReducer<DeviceInfoModel, UpdateDeviceInfo>(_updateDeviceLoaded)
]);

DeviceInfoModel _updateDeviceLoaded(DeviceInfoModel deviceInfo, action) {
  deviceInfo = action.deviceInfo;
  return deviceInfo;
}

class UpdateDeviceInfo {
  final DeviceInfoModel deviceInfo;

  UpdateDeviceInfo(this.deviceInfo);
}
/************* end *************/


/************* 宠物列表信息 *************/
/// 宠物列表
final PetListReducer = combineReducers<List<PetModel>>([
  TypedReducer<List<PetModel>, UpdatePetList>(_updatePetList)
]);

List<PetModel> _updatePetList(List<PetModel> models, UpdatePetList action) {
  models = action.petList;
  return models;
}

class UpdatePetList {
  final List<PetModel> petList;

  UpdatePetList(this.petList);
}
/************* end *************/



/************* 当前宠物信息 *************/
final CurrentPetReducer = combineReducers<PetModel>([
  TypedReducer<PetModel, UpdateCurrentPet>(_updateCurrentPet)
]);

PetModel _updateCurrentPet(PetModel model, UpdateCurrentPet action) {
  model = action.model;
  SharedUtils.setString(ShareConstant.petModel, jsonEncode(action.model.toJson()));
  return model;
}

class UpdateCurrentPet {
  final PetModel model;

  UpdateCurrentPet(this.model);
}
/************* end *************/


