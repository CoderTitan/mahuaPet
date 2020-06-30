

import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../models/pet_model.dart';



class HomeRequest {
  
  // 获取宠物列表
  static Future<List<PetModel>> requestPetList() async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = '${HttpConfig.selectUserId}?userId=${loginInfo.userId}';
    
    final value = await HttpRequest.request(url);
    if (value.isSuccess) {
      if (value.data == null) {
        return [];
      }
      List<dynamic> jsonArr = value.data;
      List<PetModel> pets = [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        pets.add(PetModel.fromJson(mapJson));
      }
      return pets;
    }
    return [];
  }
}