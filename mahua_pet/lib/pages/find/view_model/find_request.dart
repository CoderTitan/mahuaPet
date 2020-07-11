

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';

import '../models/model_index.dart';

class FindRequest {
  
  /// 发现-关注-推荐关注
  static Future<List<FocusModel>> requestRecomFocus() async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.selectNotRelation + '?pageIndex=1&pageSize=3&userLoginId=${loginInfo.userId}';

    final result = await HttpRequest.request(url);
    List<FocusModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          focus.add(FocusModel.fromJson(mapJson));
        }
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现-关注-动态列表
  static Future<List<FocusPostModel>> requestFocusPostList(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.user_selectNotRelation + '?listType=2&pageIndex=$pageIndex&pageSize=10&total=388&userLoginId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);

    List<FocusPostModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          focus.add(FocusPostModel.fromJson(mapJson));
        }
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现, 推荐---轮播图
  static Future<List<FindTopicModel>> requestTopicList() async {
    final url = HttpConfig.selectMessageLabelList + '?pageIndex=1&pageSize=10';
    final result = await HttpRequest.request(url);

    List<FindTopicModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          focus.add(FindTopicModel.fromJson(mapJson));
        }
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现-推荐: 瀑布流列表
  static Future<List<RecommendModel>> requestRecommendList(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.selectMessageRecommendList + '?messageTotal=8022&pageIndex=$pageIndex&reportTotal=483&userLoginId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);
    
    List<RecommendModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['messageList'] != null) {
        List<dynamic> jsonArr = result.data['messageList'] ?? [];
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          focus.add(RecommendModel.fromJson(mapJson));
        }
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现- 动态详情
  static Future<DetailModel> requestFindDetail(int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.find_detail + '?messageId=$messageId&userId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);
    
    DetailModel model = DetailModel();
    if (result.isSuccess) {
      if (result.data != null) {
        Map<String, dynamic> mapJson = result.data;
        model = DetailModel.fromJson(mapJson);
      }
    } else {
      TKToast.showError(result.message);
    }
    return model;
  }

  /// 发现-动态详情-评论列表
  static Future<List<CommentModel>> requestCommentList(int messageId, int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = HttpConfig.selectCommentPage + '?messageId=$messageId&pageIndex=$pageIndex&pageSize=10&replySize=5&userId=${loginInfo.userId}&userLoginId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);
    
    List<CommentModel> comments = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        for (var json in jsonArr) {
          Map<String, dynamic> mapJson = json;
          comments.add(CommentModel.fromJson(mapJson));
        }
      }
    } else {
      TKToast.showError(result.message);
    }
    return comments;
  }

  /// 发现--关注/取消关注
  static Future<bool> requestFocus(bool attation, int userByid) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int isFlag = attation ? 0 : 1;

    final url = HttpConfig.updateAttation + '?isFlag=$isFlag&userByid=$userByid&userId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);

    if (!result.isSuccess) {
      TKToast.showToast(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现--点赞/取消点赞
  static Future<bool> requestAgree(bool agree, int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int agreeStatus = agree ? 0 : 1;
    
    final url = HttpConfig.updateAgree + '?agreeStatus=$agreeStatus&messageId=$messageId&userId=${loginInfo.userId}';
    final result = await HttpRequest.request(url);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现--收藏/取消收藏
  static Future<bool> requestCollection(bool collection, int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int state = collection ? 0 : 1;
    
    final url = HttpConfig.user_collection;
    Map<String, dynamic> params = {
      'collectionsStatus': state,
      'messageId': messageId,
      'token': loginInfo.token,
      'userId': loginInfo.userId
    };
    final result = await HttpRequest.request(url, method: 'post', params: params);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }
}