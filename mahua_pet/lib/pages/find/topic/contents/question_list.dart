
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/component/component.dart';
import '../view_model/topic_http.dart';
import '../../models/model_index.dart';
import '../models/question_list_model.dart';
import '../views/question_list_item.dart';
import 'answer_page.dart';

class QuestionList extends StatefulWidget {
  final QuestionModel model;
  final bool isHot;

  QuestionList({Key key, this.model, this.isHot}): super(key: key);

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> with AutomaticKeepAliveClientMixin {
  List<QuestionListModel> _dataList = [];
  int _postPage = 1;
  bool _showLoading = true;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: _onLoading,
      child: renderListView(),
    );
  }

  Widget renderListView() {
    if (_showLoading) {
      return Center(
        child: RefreshProgressIndicator(
          strokeWidth: 3.px,
        ),
      );
    }
    return ListView.builder(
      itemCount: _dataList.length,
      itemBuilder: (ctx, index) {
        final model = _dataList[index];
        return GestureDetector(
          child: QuestionListItem(key: ValueKey(index), model: model),
          onTap: () {
            TKRoute.push(context, AnswerPage(model: model, questionModel: widget.model));
          },
        );
      }
    );
  }

  void _onRefresh () {
    _postPage = 1;
    requestDataList(1);
  }

  void _onLoading () {
    _postPage += 1;
    TKToast.showLoading();
    requestDataList(_postPage);
  }

  void requestDataList(pageIndex) {
    TopicHttp.loadAnswerList(pageIndex: pageIndex, questionId: widget.model.questionId, isHot: widget.isHot)
      .then((value) {
        TKToast.dismiss();
        _showLoading = false;
        if (pageIndex == 1) {
          _dataList = value;
          _refreshController.refreshCompleted();
          if (value.length >= 10) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        } else {
          _dataList.addAll(value);
          if (value.length >= 10) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        }
        setState(() {});
      }).catchError((error) {
        TKToast.dismiss();
        _showLoading = false;
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        print(error);
        setState(() {});
      });
  }

}