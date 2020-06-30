import 'package:flutter/material.dart';

import 'package:mahua_pet/pages/home/models/pet_model.dart';
import 'package:mahua_pet/pages/home/request/home_request.dart';


class PetViewModel extends ChangeNotifier {

  // PetViewModel();
  
  List<PetModel> _petList = [];
  PetModel _currentModel = PetModel();

  List<PetModel> get petArray {
    return _petList;
  }

  set petList(List<PetModel> value) {
    _petList = value;
    notifyListeners();
  }

  PetModel get currentModel {
    
    return _currentModel;
  }

  set currentModel(PetModel petModel) {
    _currentModel = petModel;
    notifyListeners();
  }

  PetViewModel() {
    HomeRequest.requestPetList().then((value) {
      petList = value;
      if (_currentModel.petId != null && _currentModel.petId > 0) {
        final models = value.where((element) => element.petId == _currentModel.petId).toList();
        currentModel = models.first;
      }
      if (_petList.length > 0) {
        currentModel = value.first;
      }
    });
  }
}