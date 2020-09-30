import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/find/view_model/topic_page_provide.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import '../models/model_index.dart';
import 'topic_url.dart';

class TopicStateProvider extends TopicPageProvider {


  QuestionModel _currentModel;

  QuestionModel get currentModel => _currentModel;
  set currentModel(QuestionModel model) {
    _currentModel = model;
    notifyListeners();
  }


  void agreeAction(QuestionModel model) async {
    final status = int.parse(model.agreeStatus);
    LoginInfo loginInfo = SharedStorage.loginInfo;
    final url = TopicURL.updateAgree + '?agreeStatus=$status&answerId=${model.answerId}&userId=${loginInfo.userId}';
    
    ResponseData result = await TKRequest.getRequest(url);
    if (result.isSuccess) {
      if (status == 0) {
        model.agreeNum = model.agreeNum + 1;
        model.agreeStatus = '1';
        TKToast.showSuccess('点赞成功');
      } else {
        model.agreeStatus = '0';
        model.agreeNum = model.agreeNum - 1;
        TKToast.showSuccess('取消点赞成功');
      }
      currentModel = model;
      list.forEach((element) {
        if (element.answerId == model.answerId) {
          element.agreeStatus = model.agreeStatus;
          element.agreeNum = model.agreeNum;
        }
      });
    }
  }
}