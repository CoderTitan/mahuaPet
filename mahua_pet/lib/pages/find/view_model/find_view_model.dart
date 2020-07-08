
import 'package:flutter/material.dart';
import 'package:mahua_pet/config/config_index.dart';

import '../models/find_topic_model.dart';
import '../models/focus_model.dart';


class FindViewModel extends ChangeNotifier {
  
  /// 关注, 推荐关注列表
  List<FocusModel> _focusModels = [];
  set focusModels(List<FocusModel> value) {
    _focusModels = value;
    notifyListeners();
  }
  List<FocusModel> get focusModels {
    return _focusModels;
  }

  /// 话题轮播列表
  List<FindTopicModel> _topicModels = [];
  set topicModels(List<FindTopicModel> value) {
    _topicModels = value;
    notifyListeners();
  }
  List<FindTopicModel> get topicModels {
    return _topicModels;
  }

}