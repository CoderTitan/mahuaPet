
import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/find/models/model_index.dart';
import 'package:mahua_pet/pages/find/view_model/view_model_index.dart';
import 'package:mahua_pet/pages/home/models/model_index.dart';
import 'package:mahua_pet/pages/home/view_model/view_model_index.dart';
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

  /// 首页推荐列表
  static Future requestHomeRecomList(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.selectMessageRecommendList + '?messageTotal=8871&pageIndex=$pageIndex&reportTotal=26&userLoginId=${loginInfo.userId}';
    ResponseData result = await TKRequest.requestData(url);
    
    List<RecommendModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['messageList'] != null) {
        List<dynamic> jsonArr = result.data['messageList'] ?? [];
        focus = jsonArr.map<RecommendModel>((item) => RecommendModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 首页种草详情
  static Future loadGrassDetail(int trialId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.getTrialReportInfo;
    final params = {'loginUserId': loginInfo.userId, 'trialReportId': trialId};
    ResponseData result = await TKRequest.postRequest(url, params);

    GrassModel model = GrassModel();
    if (result.isSuccess) {
      if (result.data != null) {
        model = GrassModel.fromJson(result.data);
      }
    } else {
      TKToast.showError(result.message);
    }
    return model;
  }

  /// 首页种草详情点赞
  static Future loadGrassAgree(int trialId, int agreeStatus) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.updateTrialReportAgree;
    final params = {'userId': loginInfo.userId, 'trialReportId': trialId, 'agreeStatus': agreeStatus};
    ResponseData result = await TKRequest.postRequest(url, params);

    if (result.isSuccess) {
      if (agreeStatus == 1) {
        TKToast.showSuccess('取消点赞成功');
      } else {
        TKToast.showSuccess('点赞成功');
      }
    } else {
      TKToast.showError(result.message);
    }
  }

  /// 首页种草详情收藏
  static Future loadGrassCollect(int trialId, int collectionsStatus) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.collectionApi;
    final params = {'userId': loginInfo.userId, 'trialReportId': trialId, 'collectionsStatus': collectionsStatus};
    ResponseData result = await TKRequest.postRequest(url, params);

    if (result.isSuccess) {
      if (collectionsStatus == 1) {
        TKToast.showSuccess('取消收藏成功');
      } else {
        TKToast.showSuccess('收藏成功');
      }
    } else {
      TKToast.showError(result.message);
    }
  }
}