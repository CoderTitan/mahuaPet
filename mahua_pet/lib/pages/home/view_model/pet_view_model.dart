import 'package:flutter/material.dart';

import 'package:mahua_pet/pages/home/models/pet_model.dart';


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
}