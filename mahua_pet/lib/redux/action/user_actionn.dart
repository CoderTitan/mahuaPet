
import 'package:redux/redux.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/config/config_index.dart';

import '../models/model_index.dart';
import '../reducer/reducer_index.dart';

/// 网络强求数据
class FetchUserInfoAction {
  /// 获取用户信息
  static Future loadUserData(Store store) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.userIndex;
    final httpURL = url + '?userId=${loginInfo.userId}';

    ResponseData response = await TKRequest.getRequest(httpURL);
    UserInfoModel userInfo = UserInfoModel();
    if (response.isSuccess) {
      if (response.data != null) {
        userInfo = UserInfoModel.fromJson(response.data);
      }
      store.dispatch(UpdateUserInfo(userInfo));
    } 
  }

  // 获取宠物列表
  static void loadPetList(Store store) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = '${HttpConfig.selectUserId}?userId=${loginInfo.userId}';
    
    ResponseData response = await TKRequest.getRequest(url);

    List<PetModel> modelList = [];
    if (response.isSuccess) {
      if (response.data != null) {
        List<dynamic> jsonArr = response.data ?? [];
        modelList = jsonArr.map((e) => PetModel.fromJson(e)).toList();
      }
      store.dispatch(UpdatePetList(modelList));
    } 
  }
}