
import 'package:redux/redux.dart';
import '../models/model_index.dart';


/// 我的用户信息
// 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final UserInfoModelReducer = combineReducers<UserInfoModel>([
  TypedReducer<UserInfoModel, UpdateUserInfo>(_updateLoaded)
]);

UserInfoModel _updateLoaded(UserInfoModel userInfo, action) {
  userInfo = action.userInfo;
  return userInfo;
}

class UpdateUserInfo {
  final UserInfoModel userInfo;

  UpdateUserInfo(this.userInfo);
}


/// 宠物列表
final PetListReducer = combineReducers<List<PetModel>>([
  TypedReducer<List<PetModel>, UpdatePetList>(_updatePetList)
]);

List<PetModel> _updatePetList(List<PetModel> models, action) {
  models = action.petList;
  return models;
}


class UpdatePetList {
  final List<PetModel> petList;

  UpdatePetList(this.petList);
}
