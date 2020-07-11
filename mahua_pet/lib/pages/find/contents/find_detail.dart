import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import '../view_model/find_request.dart';
import '../models/model_index.dart';
import '../views/comment_item.dart';
import '../views/detail_item.dart';



typedef FindDetailCallBack = void Function(DetailModel model);


class FindDetailPage extends StatefulWidget {

  static const routeName = '/find_detail';

  final int messageId;
  final FindDetailCallBack actionCallBack;
  FindDetailPage({this.messageId, this.actionCallBack});

  @override
  _FindDetailPageState createState() => _FindDetailPageState();
}

class _FindDetailPageState extends State<FindDetailPage> {

  DetailModel _model = DetailModel();
  List<CommentModel> _commentList = [];
  int _postPage = 1;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _showLoading = false;

  @override
  void initState() { 
    super.initState();
    
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动态详情')),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: renderListView(),
            ),
            renderBottomItem()
          ],
        )
      ),
    );
  }

  Widget renderListView() {

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
              child: FindDetailItem(_model, (type) => handleItemAction(type)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => CommentItem(model: _commentList[index], userId: _model.userId, key: ValueKey(index)),
              childCount: _commentList.length
            )
          )
        ],
      ),
    );
  }

  Widget renderBottomItem() {
    return Container(
      height: 57.px + SizeFit.safeHeight,
      padding: EdgeInsets.only(bottom: SizeFit.safeHeight),
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border(top: BorderSide(color: TKColor.color_cccccc, width: 0.5))
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 7.px),
                decoration: BoxDecoration(
                  color: TKColor.color_f7f7f7,
                  borderRadius: BorderRadius.circular(20.px)
                ),
                child: Text('快来评论小可爱吧...', style: TextStyle(fontSize: 15.px, color: TKColor.color_999999)),
              ),
              onTap: () {},
            ),
            Row(
              children: <Widget>[
                bottomItem(
                  _model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border, 
                  _model.agreeStatus == '1' ? TKColor.main_color : TKColor.color_666666, 
                  '${_model.cntAgree}', 0
                ),
                SizedBox(width: 30.px),
                bottomItem(
                  _model.collectionsStatus == '1' ? Icons.star : Icons.star_border, 
                  _model.collectionsStatus == '1' ? TKColor.main_color : TKColor.color_666666, 
                  _model.collectionNum, 1
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomItem(IconData icon, Color iconColor, String number, int index) {
    return GestureDetector(
      child: Container(
        // width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 20.px, color: iconColor,),
            Text('$number', style: TextStyle(fontSize: 13.px, color: TKColor.color_666666))
          ],
        ),
      ),
      onTap: () {
        if (index == 0) {
          requestAgreeState();
        } else if (index == 1) {
          requestCollectState();
        }
      },
    );
  }

  void _onRefresh() {
    if (_showLoading) {
      TKToast.showLoading();
    }
    requestFindDetail();
    requestCommentList(1);
  }

  void _onLoading() {
    if (_showLoading) {
      TKToast.showLoading();
    }
    _postPage += 1;
    requestCommentList(_postPage);
  }

  void requestFindDetail() {
    FindRequest.requestFindDetail(widget.messageId).then((value) {
      setState(() {
        _model = value;
      });
      _showLoading = true;
    }).catchError((error) {
      print(error);
    });
  }

  void requestCommentList(pageIndex) {
    FindRequest.requestCommentList(widget.messageId, pageIndex).then((value) {
      TKToast.dismiss();
      _showLoading = true;
      if (pageIndex == 1) {
        _commentList = value;
        _refreshController.refreshCompleted();
        if (value.length >= 10) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        _commentList.addAll(value);
        if (value.length >= 10) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      }
      setState(() {});
    }).catchError((error) {
      TKToast.dismiss();
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      print(error);
    });
  }

  void handleItemAction(FindActionType type) {
    switch (type) {
      case FindActionType.header:
        print(FindActionType.header);
        break;
      case FindActionType.attation:
        requestAttation();
        break;
      case FindActionType.agree:
        requestAgreeState();
        break;
      case FindActionType.collection:
        requestCollectState();
        break;
      case FindActionType.comment:
        print(FindActionType.comment);
        break;
      case FindActionType.share:
        print(FindActionType.share);
        break;
      default:
    }
  }

  // 关注
  void requestAttation() {
    TKToast.showLoading();
    FindRequest.requestFocus(_model.followStatus == '关注', _model.userId)
      .then((value) {
        if (value) {
          if (_model.followStatus != '关注') {
            
            TKToast.showSuccess('关注成功');
          } else {
            TKToast.showSuccess('取消关注成功');
          }
          _model.followStatus = _model.followStatus == '关注' ? '+关注' : '关注';
          widget.actionCallBack(_model);
          setState(() { });
        }
      }).catchError((error) {
        TKToast.dismiss();
        print(error);
      });
  }

  // 点赞
  void requestAgreeState() {
    TKToast.showLoading();
    FindRequest.requestAgree(_model.agreeStatus == '0', _model.messageId).then((value) {
      if (value) {
        if (_model.agreeStatus == '0') {
          _model.cntAgree = _model.cntAgree + 1;
          TKToast.showSuccess('点赞成功');
        } else {
          _model.cntAgree = _model.cntAgree - 1;
          TKToast.showSuccess('取消点赞成功');
        }
        _model.agreeStatus = _model.agreeStatus == '0' ? '1' : '0';
        widget.actionCallBack(_model);
        setState(() { });
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }

  // 收藏
  void requestCollectState() {
    TKToast.showLoading();
    FindRequest.requestCollection(_model.collectionsStatus == '0', _model.messageId).then((value) {
      if (value) {
        if (_model.collectionsStatus == '0') {
          _model.collectionNum = '${int.parse(_model.collectionNum) + 1}';
          TKToast.showSuccess('收藏成功');
        } else {
          _model.collectionNum = '${int.parse(_model.collectionNum) - 1}';
          TKToast.showSuccess('取消收藏成功');
        }
        _model.collectionsStatus = _model.collectionsStatus == '0' ? '1' : '0';
        setState(() { });
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }
}