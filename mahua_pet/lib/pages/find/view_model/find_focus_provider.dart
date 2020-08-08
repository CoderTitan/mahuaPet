
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'find_request.dart';


/// 发现-推荐关注列表
class FindRecomFocusProvider extends ViewRefresh {

  @override
  Future<List> loadData() async {
    var result = await FindRequest.requestRecomFocus();
    return result;
  }

  void requestFocusState(FocusModel model) async {
    TKToast.showLoading();
    FindRequest.requestFocus(model.isRelation, model.userId).then((value) {
      if (value) {
        if (!model.isRelation) {
          TKToast.showSuccess('关注成功');
        } else {
          TKToast.showSuccess('取消关注成功');
        }
        list.forEach((element) {
          if (element.userId == model.userId) {
            element.isRelation = !model.isRelation;
          }
        });
        notifyListeners();
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }
}

/// 发现-关注list
class FindFocusProvider extends ViewListRefresh {
  List<FocusPostModel> _postArray = [];

  List<FocusPostModel> get postArray => _postArray;

  void setPostArray(List<dynamic> value) {
    _postArray = value.map((e) {
      FocusPostModel model = e;
      return model;
    }).toList();
  }

  @override
  Future<List<FocusPostModel>> loadData({int pageIndex}) async {
    var result = await FindRequest.requestFocusPostList(pageIndex);
    return result;
  }

  void reloadList(FocusPostModel model) {
    List<dynamic> newModels = list.where((element) => element.userId != model.userId).toList();
    list = newModels;
    notifyListeners();
  }
}


/// 发现-关注list-item
class FindItemProvider extends FindFocusProvider {

  /// 发现-关注model
  FocusPostModel _postModel;
  FocusPostModel get postModel => _postModel;
  set postModel(FocusPostModel model) {
    _postModel = model;
    list.forEach((element) {
      if (element.messageId == model.messageId) {
        element = model;
      }
    });
    notifyListeners();
  }

  /// 点赞
  void requestAgreeState(FocusPostModel model) {
    TKToast.showLoading();
    FindRequest.requestAgree(model.agreeStatus == '0', messageId: model.messageId).then((value) {
      if (value) {
        if (model.agreeStatus == '0') {
          model.agreeStatus = '1';
          model.cntAgree = model.cntAgree + 1;
          TKToast.showSuccess('点赞成功');
        } else {
          model.agreeStatus = '0';
          model.cntAgree = model.cntAgree - 1;
          TKToast.showSuccess('取消点赞成功');
        }
        postModel = model;
      }
    });
  }

  /// 关注
  void requestFocusState(FocusPostModel model, FindActionCallBack actionCallback) {
    TKToast.showLoading();
    FindRequest.requestFocus(model.followStatus != '未关注', model.userId).then((value) {
      if (value) {
        if (model.followStatus == '未关注') {
          TKToast.showSuccess('关注成功');
        } else {
          TKToast.showSuccess('取消关注成功');
        }
        actionCallback(FindActionType.attation);
      }
    });
  }
}

