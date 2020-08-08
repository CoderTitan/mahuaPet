
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'find_request.dart';


/// 发现-推荐列表
class FindRecommendProvider extends ViewListRefresh {

  List<FindTopicModel> _topicArray = [];
  List<FindTopicModel> get topicArray => _topicArray;

  @override
  Future<List> loadData({int pageIndex = 1}) async {

    List<Future> futures = [];

    if (pageIndex == 1) {
      futures.add(FindRequest.requestTopicList());
      futures.add(FindRequest.requestRecommendList(1));
    }
    futures.add(FindRequest.requestRecommendList(pageIndex));

    var result = await Future.wait(futures);
    if (pageIndex == 1) {
      _topicArray = result[0];
      return result[1];
    } else {
      return result[0];
    }
  }

  @override
  Future<List> loadMoreData() async {
    try {
      final pageIndex = currentPage + 1;
      var data = await loadData(pageIndex: pageIndex);
      if (data.isEmpty) {
        refreshController.loadNoData();
      } else {
        currentPage++;
        onCompleted(data);
        list.addAll(data);
        refreshController.refreshCompleted();

        if (data.length == 0) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      refreshController.loadFailed();
      return null;
    }
  }
}

/// 发现-推荐list-item
class FindRecomItemProvider extends ViewStateModel {
  /// 发现-关注model
  RecommendModel _recomModel;
  RecommendModel get recomModel => _recomModel;
  set recomModel(RecommendModel model) {
    _recomModel = model;
    notifyListeners();
  }

  /// 点赞
  void requestAgreeState(RecommendModel model) {
    TKToast.showLoading();
    FindRequest.requestAgree(model.agreeStatus == '0', messageId: model.messageId).then((value) {
      if (value) {
        if (model.agreeStatus == '0') {
          model.agreeStatus = '1';
          model.messageAgreeNum = '${int.parse(model.messageAgreeNum) + 1}';
          TKToast.showSuccess('点赞成功');
        } else {
          model.agreeStatus = '0';
          model.messageAgreeNum = '${int.parse(model.messageAgreeNum) - 1}';
          TKToast.showSuccess('取消点赞成功');
        }
        recomModel = model;
      }
    });
  }
}