

import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/home/models/swiper_model.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/pages/home/view_model/pet_view_model.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:provider/provider.dart';
import '../../../redux/models/pet_model.dart';
import '../models/model_index.dart';



class HomeRequest {
  
  // 获取宠物列表
  static void requestPetList(BuildContext context) {
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
        PetViewModel petVM = Provider.of<PetViewModel>(context, listen: false);
        petVM.petList = pets;
      }
    }).catchError((error) {
      print(error);
    });
  }

  // 获取轮播图
  static void requestHomeSwiper(BuildContext context) {
    final url = '${HttpConfig.selectPageList}?locationName=2&locationPage=1';
    TKRequest.requestData(url).then((value) {
      List<SwiperModel> swipers = [];
      if (value.isSuccess) {
        Map<String, dynamic> maps = value.data ?? {};
        List<dynamic> jsonArr = maps['records'] ?? [];
        
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          final model = SwiperModel.fromJson(mapJson);
          swipers.add(model);
        }
      }
      HomeViewModel homeVM = Provider.of<HomeViewModel>(context, listen: false);
      homeVM.swiperArray = swipers;
    }).catchError((error) {
      print(error);
    });
  }

  /// 获取种草列表
  static Future requestHomeGrass(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = '${HttpConfig.getTrialReportList}?auditStatus=1&pageIndex=$pageIndex&pageSize=10&userLoginId=${loginInfo.userId}';

    ResponseData result = await TKRequest.requestData(url);

    List<GrassModel> models = [];
    if (result.isSuccess) {
      Map<String, dynamic> maps = result.data ?? {};
      List<dynamic> jsonArr = maps['records'] ?? [];
      
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        final model = GrassModel.fromJson(mapJson);
        models.add(model);
      }
    } else {
      TKToast.showError(result.message);
    }
    return models;
  }

}