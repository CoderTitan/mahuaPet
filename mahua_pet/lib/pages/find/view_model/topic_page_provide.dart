
import 'package:mahua_pet/config/config_index.dart';
import '../models/model_index.dart';
import 'topic_http.dart';

class TopicPageProvider extends ViewListRefresh {
  /// 热门话题
  List<HotTopicModel> _topicArray = [];
  List<HotTopicModel> get topicArray => _topicArray;

  @override
  Future<List> loadData({int pageIndex = 1}) async {
    List<Future> futures = [];

    if (pageIndex == 1) {
      futures.add(TopicHttp.fetchTopics());
      futures.add(TopicHttp.fetchQuestions());
    }
    futures.add(TopicHttp.fetchQuestions(index: pageIndex));

    var result = await Future.wait(futures);
    if (pageIndex == 1) {
      _topicArray = result[0];
      return result[1];
    } else {
      return result[0];
    }
  }
}