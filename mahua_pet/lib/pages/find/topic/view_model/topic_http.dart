import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import '../models/model_index.dart';
import '../models/question_list_model.dart';

class TopicURL {
  /// 热门列表
  /// post: /user/tribe/allTribeList
  /// pageIndex=1&pageSize=10&userId=136899
  static const String allTribeList = '/user/tribe/allTribeList';

  /// 犬种信息
  /// post: /user/tribe/selectTribeInfo
  /// loginUserId=136899&tribeId=7
  static const String selectTribeInfo = '/user/tribe/selectTribeInfo';

  /// 讨论列表
  /// get: /user/question/v1911/lik/selectQuestionList?orderType=1&pageIndex=1&pageSize=10&tribeId=17&userId=136899
  static const String selectQuestionList = '/user/question/v1911/lik/selectQuestionList';

  /// 热门列表关注
  /// post: user/tribeUser/updateTribeUser, delFlag=0&tribeId=24&userId=136899
  /// delFlag: 0, 关注, 1:取消关注
  static const String updateTribeUser = '/user/tribeUser/updateTribeUser';

  /// 问题回答列表-最热
  /// get: user/answer/v1911/zyz/selectHotAnswerPage?pageIndex=1&pageSize=10&questionId=99&userId=136899
  static const String selectHotAnswerPage = '/user/answer/v1911/zyz/selectHotAnswerPage';

  /// 问题回答列表-最新
  /// get: user/answer/v1911/zyz/selectNewAnswerPage?pageIndex=1&pageSize=10&questionId=99&userId=136899
  static const String selectNewAnswerPage = '/user/answer/v1911/zyz/selectNewAnswerPage';

  /// 问题答案
  /// get: user/question/v1911/zyz/selectQuestionAnswers?
  /// answerId=550&pageIndex=1&pageSize=1&questionId=99&userId=136899&userLoginId=136899
  static const String selectQuestionAnswers = '/user/question/v1911/zyz/selectQuestionAnswers';
}

class TopicHttp {
  /// 全部热门话题
  static Future loadTopicList(int pageIndex) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final params = {'pageIndex': pageIndex, 'pageSize': 10, 'userId': loginInfo.userId};

    ResponseData response = await TKRequest.postRequest(TopicURL.allTribeList, params);
    List<BreedModel> models = [];
    if (response.isSuccess) {
      if (response.data != null && response.data['records'] != null) {
        final records = response.data['records'] ?? [];
        models = records.map<BreedModel>((item) => BreedModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(response.message);
    }
    return models;
  }

  /// 犬种信息
  static Future loadTribeInfo(String tribeId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final params = {'tribeId': tribeId, 'loginUserId': loginInfo.userId};

    ResponseData response = await TKRequest.postRequest(TopicURL.selectTribeInfo, params);
    BreedModel model = BreedModel();

    if (response.isSuccess) {
      if (response.data != null) {
        model = BreedModel.fromJson(response.data);
      }
    } else {
      TKToast.showError(response.message);
    }
    return model;
  }

  /// 讨论列表
  static Future loadQuestionList({int pageIndex, String tribeId, int orderType}) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = TopicURL.selectQuestionList + '?orderType=$orderType&pageIndex=$pageIndex&pageSize=10&tribeId=$tribeId&userId=${loginInfo.userId}';

    ResponseData response = await TKRequest.getRequest(url);
    List<QuestionModel> models = [];
    int count = 0;
    if (response.isSuccess) {
      if (response.data != null && response.data['records'] != null) {
        final records = response.data['records'] ?? [];
        models = records.map<QuestionModel>((item) => QuestionModel.fromJson(item)).toList();
        count = response.data['total'] ?? 0;
      }
    } else {
      TKToast.showError(response.message);
    }
    Map<String, dynamic> maps = {'models': models, 'count': count};
    return maps;
  }

  /// 热门列表关注
  static Future<bool> requestFocus(String attation, String tribeId) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    int delFlag = int.parse(attation);

    final params = {'delFlag': delFlag, 'tribeId': tribeId, 'userId': loginInfo.userId};
    ResponseData result = await TKRequest.postRequest(TopicURL.updateTribeUser, params);

    if (!result.isSuccess) {
      TKToast.showToast(result.message);
    }
    
    return result.isSuccess;
  }


  /// 问题回答列表
  static Future loadAnswerList({int pageIndex, int questionId, bool isHot}) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = isHot ? TopicURL.selectHotAnswerPage : TopicURL.selectNewAnswerPage;
    final httpURL = url + '?questionId=$questionId&pageIndex=$pageIndex&pageSize=10&userId=${loginInfo.userId}';

    ResponseData response = await TKRequest.getRequest(httpURL);
    List<QuestionListModel> models = [];
    if (response.isSuccess) {
      if (response.data != null && response.data['records'] != null) {
        final records = response.data['records'] ?? [];
        models = records.map<QuestionListModel>((item) => QuestionListModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(response.message);
    }
    return models;
  }

  /// 问题回答列表
  static Future requestAnswer({int pageIndex, int answerId, int questionId}) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final params = '?answerId=$answerId&pageIndex=$pageIndex&pageSize=1&questionId=$questionId&userId=${loginInfo.userId}&userLoginId=${loginInfo.userId}';
    final httpURL = TopicURL.selectQuestionAnswers + params;

    ResponseData response = await TKRequest.getRequest(httpURL);
    Map<String, AnswerModel> models = {};
    if (response.isSuccess) {
      if (response.data != null && response.data['answerVOPage'] != null) {
        Map<String, dynamic> maps = response.data['answerVOPage'];
        List records = maps['records'] ?? [];
        if (records.length > 0) {
          Map<String, dynamic> answer = records.first ?? {};
          final current = AnswerModel.fromJson(answer['answer'] ?? {});
          final next = AnswerModel.fromJson(answer['answerNext'] ?? {});
          models['current'] = current;
          models['next'] = next;
        }
      }
    } else {
      TKToast.showError(response.message);
    }
    return models;
  }
}