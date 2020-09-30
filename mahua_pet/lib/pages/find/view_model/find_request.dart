

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';

import '../models/model_index.dart';
import 'find_url.dart';

class FindRequest {
  
  /// 发现-关注-推荐关注
  static Future requestRecomFocus() async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.selectNotRelation + '?pageIndex=1&pageSize=3&userLoginId=${loginInfo.userId}';

    ResponseData response = await TKRequest.requestData(url);
    List<FocusModel> focus = [];
    if (response.isSuccess) {
      if (response.data != null && response.data['records'] != null) {
        final records = response.data['records'] ?? [];
        focus = records.map<FocusModel>((item) => FocusModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(response.message);
    }
    return focus;
  }

  /// 发现-关注-动态列表
  static Future requestFocusPostList(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.user_selectNotRelation + '?listType=2&pageIndex=$pageIndex&pageSize=10&total=388&userLoginId=${loginInfo.userId}';
    ResponseData result = await TKRequest.requestData(url);

    List<FocusPostModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        focus = jsonArr.map<FocusPostModel>((item) => FocusPostModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现, 推荐---轮播图
  static Future requestTopicList() async {
    final url = FindURL.selectMessageLabelList + '?pageIndex=1&pageSize=10';
    ResponseData result = await TKRequest.requestData(url);

    List<FindTopicModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        focus = jsonArr.map<FindTopicModel>((item) => FindTopicModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现-推荐: 瀑布流列表
  static Future requestRecommendList(int pageIndex) async {
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

  /// 热门讨论-最新最热
  static Future requestTolkList(int labelId, int orderType, int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.getMessageBylabel + '?messageLabelId=$labelId&orderType=$orderType&pageIndex=$pageIndex&pageSize=10&userLoginId=${loginInfo.userId}';
    ResponseData result = await TKRequest.requestData(url);
    
    List<RecommendModel> focus = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        focus = jsonArr.map<RecommendModel>((item) => RecommendModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(result.message);
    }
    return focus;
  }

  /// 发现- 动态详情
  static Future<DetailModel> requestFindDetail(int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.find_detail + '?messageId=$messageId&userId=${loginInfo.userId}';
    final result = await TKRequest.requestData(url);
    
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
    final url = FindURL.selectCommentPage + '?messageId=$messageId&pageIndex=$pageIndex&pageSize=10&replySize=5&userId=${loginInfo.userId}&userLoginId=${loginInfo.userId}';
    final result = await TKRequest.requestData(url);
    
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

    final url = FindURL.updateAttation + '?isFlag=$isFlag&userByid=$userByid&userId=${loginInfo.userId}';
    ResponseData result = await TKRequest.requestData(url);

    if (!result.isSuccess) {
      TKToast.showToast(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现--点赞/取消点赞
  static Future<bool> requestAgree(bool agree, {int messageId, int commentId}) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int agreeStatus = agree ? 0 : 1;
    
    final url = FindURL.updateAgree + '?agreeStatus=$agreeStatus&messageId=$messageId&commentId=$commentId&userId=${loginInfo.userId}';
    final result = await TKRequest.requestData(url);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现--收藏/取消收藏
  static Future<bool> requestCollection(bool collection, int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int state = collection ? 0 : 1;
    
    final url = FindURL.user_collection;
    Map<String, dynamic> params = {
      'collectionsStatus': state,
      'messageId': messageId,
      'token': loginInfo.token,
      'userId': loginInfo.userId
    };
    final result = await TKRequest.requestData(url, method: 'post', params: params);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现-评论
  static Future<bool> requestComment(String commentInfo, int messageId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;

    final url = FindURL.comment_save;
    Map<String, dynamic> params = {
      'commentInfo': commentInfo,
      'messageId': messageId,
      'token': loginInfo.token,
      'userId': loginInfo.userId
    };
    final result = await TKRequest.requestData(url, method: 'post', params: params);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现-回复评论
  static Future<bool> replyComment(String commentInfo, int commentId, int beReplyedUserId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;

    final url = FindURL.comment_reply_save;
    Map<String, dynamic> params = {
      'beReplyedUserId': beReplyedUserId,
      'commentInfo': commentInfo,
      'commentId': commentId,
      'token': loginInfo.token,
      'replyUserId': loginInfo.userId
    };
    final result = await TKRequest.requestData(url, method: 'post', params: params);

    if (!result.isSuccess) {
      TKToast.showError(result.message);
    }
    
    return result.isSuccess;
  }

  /// 发现-删除评论
  static Future<bool> deleteComment(int commentId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;

    final url = FindURL.comment_delete + '?commentId=35327&userLoginId=${loginInfo.userId}';
    final result = await TKRequest.requestData(url);

    TKToast.showToast(result.message);
    
    return result.isSuccess;
  }


  /// 获取视频列表
  static Future<List<FindVideoModel>> requestVideoList(int messageId, int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = FindURL.selectCurrentVideoPage + '?messageId=$messageId&orderColumn=create_time&pageIndex=$pageIndex&pageSize=10&userLoginId=${loginInfo.userId}';
    final result = await TKRequest.requestData(url);

    List<FindVideoModel> videos = [];
    if (result.isSuccess) {
      List<dynamic> jsonArr = result.data ?? [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        videos.add(FindVideoModel.fromJson(mapJson));
      }
    } else {
      TKToast.showError(result.message);
    }
    return videos;
  } 
}