
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';

import '../models/model_index.dart';
import 'topic_url.dart';

class TopicHttp {
  /// 首页-热门话题
  static Future fetchTopics() async {
    ResponseData response = await TKRequest.getRequest(TopicURL.getHotTribe + '?dogBreedId=102');
    if (response.data != null && response.data['records'] != null) {
      final records = response.data['records'] ?? [];
      return records
        .map<HotTopicModel>((item) => HotTopicModel.fromJson(item))
        .toList();
    }
    return [];
  }

  /// 首页-热门讨论
  static Future fetchQuestions({int index = 1}) async {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final params = '?pageIndex=$index&pageSize=10&userId=${loginInfo.userId}';
    await Future.delayed(Duration(seconds: 1)); //增加动效
    ResponseData response = await TKRequest.getRequest(TopicURL.selectQuestionHotList + params);

    if (response.data != null && response.data['records'] != null) {
      final records = response.data['records'] ?? [];
      return records
        .map<QuestionModel>((item) => QuestionModel.fromJson(item))
        .toList();
    }
    return [];
  }
}