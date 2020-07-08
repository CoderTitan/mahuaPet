import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import '../view_model/find_request.dart';
import '../models/model_index.dart';
import '../views/comment_item.dart';
import '../views/detail_item.dart';


class FindDetailPage extends StatelessWidget {

  static const routeName = '/find_detail';

  final int messageId;
  FindDetailPage({this.messageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动态详情')),
      body: _FindDetail(messageId: messageId),
    );
  }
}

class _FindDetail extends StatefulWidget {

  final int messageId;
  _FindDetail({this.messageId});

  @override
  _FindDetailState createState() => _FindDetailState();
}

class _FindDetailState extends State<_FindDetail> {

  DetailModel _model = DetailModel();
  List<CommentModel> _commentList = [];
  int _postPage = 1;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

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
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 10.px),
            sliver: SliverToBoxAdapter(
              child: FindDetailItem(_model),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => CommentItem(model: _commentList[index], key: ValueKey(index)),
              childCount: _commentList.length
            )
          )
        ],
      ),
    );
        // Container(
        //   height: 57.px,
        //   decoration: BoxDecoration(
        //     color: TKColor.white,
        //     border: Border(top: BorderSide(color: TKColor.color_cccccc, width: 0.5))
        //   ),
        // )
  }


  void _onRefresh() {
    // TKToast.showLoading();
    requestFindDetail();
    requestCommentList(1);
  }

  void _onLoading() {
    // TKToast.showLoading();
    _postPage += 1;
    requestCommentList(_postPage);
  }

  void requestFindDetail() {
    FindRequest.requestFindDetail(widget.messageId).then((value) {
      setState(() {
        _model = value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void requestCommentList(pageIndex) {
    FindRequest.requestCommentList(widget.messageId, pageIndex).then((value) {
      TKToast.dismiss();
      if (pageIndex == 1) {
        _commentList = value;
      } else {
        _commentList.addAll(value);
      }
      setState(() {});
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }).catchError((error) {
      TKToast.dismiss();
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      print(error);
    });
  }
}