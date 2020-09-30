import 'package:flutter/material.dart';

import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/redux/models/pet_model.dart';


class PetViewModel extends ChangeNotifier {
  
  List<PetModel> _petList = [];
  PetModel _currentModel = PetModel();

  List<PetModel> get petList {
    return _petList;
  }

  set petList(List<PetModel> value) {
    _petList = value;

    if (_currentModel.petId != null && _currentModel.petId > 0) {
      final models = value.where((element) => element.petId == _currentModel.petId).toList();
      if (models.length > 0) {
        currentModel = models.first;
      } else {
        currentModel = PetModel();
      }
    } else {
      if (_petList.length > 0) {
        currentModel = value.first;
      }
    }

    notifyListeners();
  }

  PetModel get currentModel {
    
    return _currentModel;
  }

  set currentModel(PetModel petModel) {
    _currentModel = petModel;
    notifyListeners();
  }

  // 获取宠物列表
  void requestPetList() {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = '${HttpConfig.selectUserId}?userId=${loginInfo.userId}';
    
    TKRequest.requestData(url).then((value) {
      List<PetModel> pets = [];
      if (value.isSuccess) {
        if (value.data != null) {
          List<dynamic> jsonArr = value.data ?? [];
          for (var json in jsonArr) {
            Map<String, dynamic> mapJson = json;
            pets.add(PetModel.fromJson(mapJson));
          }
        }
        petList = pets;
      }
    }).catchError((error) {
      print(error);
    });
  }
}