import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import '../view_model/find_request.dart';
import '../models/model_index.dart';
import '../views/comment_item.dart';
import '../views/detail_item.dart';
import '../views/find_bottom_tool.dart';



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

  DetailModel _model;
  List<CommentModel> _commentList = [];
  CommentModel _currentComment = CommentModel();
  int _postPage = 1;

  FocusNode _focusNode = FocusNode();
  TextEditingController _editController = TextEditingController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  

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
            renderListView(),
            renderBottomItem()
          ],
        )
      ),
    );
  }

  Widget renderListView() {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: <Widget>[
            renderDetail(),
            renderCommentList()
          ],
        ),
      ),
    );
  }

  Widget renderDetail() {
    if (_model == null) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.px),
      sliver: SliverToBoxAdapter(
        child: FindDetailItem(_model, (type) => handleItemAction(type)),
      ),
    );
  }

  Widget renderCommentList() {
    if (_commentList.length == 0) {
      return SliverToBoxAdapter(
        child: EmptyContent(),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return CommentItem(
            model: _commentList[index], 
            userId: _model.userId, 
            key: ValueKey(index),
            actionCallBack: (type) {
              _currentComment = _commentList[index];
              if (type == FindActionType.agree) {
                requestCommentAgree(model: _commentList[index]);
              } else if (type == FindActionType.commentSelect){
                final model = _commentList[index];
                LoginInfo loginInfo = SharedStorage.loginInfo;
                if (model.userId == loginInfo.userId) {
                  showCommentSelect();
                } else {
                  showCommentItem((text) {
                    replyComment(text);
                  });
                }
              } else {
                handleItemAction(type);
              }
            },
          );
        },
        childCount: _commentList.length
      )
    );
  }

  Widget renderBottomItem() {
    if (_model == null) {
      return Container();
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: SizeFit.safeHeight, left: 16.px, right: 30.px),
      child: FindBottomTool(
        focusNode: _focusNode,
        controller: _editController,
        submitAction: (text) => {
          postComment(text)
        },
        agreeState: _model.agreeStatus == '1',
        collectionState: _model.collectionsStatus == '1',
        agreeCount: '${_model.cntAgree}',
        collectionCount: _model.collectionNum,
        actionCallback: (type) {
          if (type == FindActionType.agree) {
            requestAgreeState();
          } else if (type == FindActionType.collection) {
            requestCollectState();
          }
        },
      ),
    );
  }
  

  void _onRefresh() {
    TKToast.showLoading();
    _postPage = 1;
    requestFindDetail();
    requestCommentList(1);
  }

  void _onLoading() {
    TKToast.showLoading();
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
        _model.commentList = value;
        widget.actionCallBack(_model);
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
        showCommentItem((text) {
          postComment(text);
        });
        break;
      case FindActionType.share:
        print(FindActionType.share);
        break;
      case FindActionType.commentSelect:
        break;
      default:
    }
  }

  /// 回复/评论
  void showCommentItem(void Function(String) action) {
    TKActionComment.showActionSheet(
      context,
      focusNode: _focusNode,
      textController: _editController,
      placehold: '快来评论小可爱吧...',
      submitAction: (text) {
        action(text);
      }
    );
  }

  /// 点击评论显示弹窗
  void showCommentSelect() {
    TKActionSheet.showActionSheet(context, rows: ['回复', '删除'], selectAction: (index, text) {
      if (index == 0) {
        // 开始倒计时
        Future.delayed(Duration(seconds: 1), () { // 回复
          showCommentItem((text) {
            replyComment(text);
          });
        });
      } else {
        // 删除
        deleteComment();
      }
    });
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
          _model.commentList = _commentList;
          widget.actionCallBack(_model);
          setState(() { });
        }
      }).catchError((error) {
        TKToast.dismiss();
        print(error);
      });
  }

  // 帖子点赞
  void requestAgreeState() {
    TKToast.showLoading();
    FindRequest.requestAgree(_model.agreeStatus == '0', messageId: _model.messageId)
      .then((value) {
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

    // 评论点赞
  void requestCommentAgree({CommentModel model}) {
    TKToast.showLoading();
    FindRequest.requestAgree(model.agreeStatus == '0', commentId: model.commentId)
      .then((value) {
        if (value) {
          if (model.agreeStatus == '0') {
            model.cntAgree = model.cntAgree + 1;
            TKToast.showSuccess('点赞成功');
          } else {
            model.cntAgree = model.cntAgree - 1;
            TKToast.showSuccess('取消点赞成功');
          }
          _commentList.forEach((element) {
            if (element.commentId == model.commentId) {
              element.agreeStatus = model.agreeStatus == '0' ? '1' : '0';
            }
          });
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

  // 评论内容
  void postComment(String message) {
    if (message == null || message.isEmpty) {
      TKToast.showToast('内容不能为空');
      return;
    }
    TKToast.showLoading();
    FindRequest.requestComment(message, _model.messageId).then((value) {
      if (value) {
        _editController.text = '';
        _onRefresh();
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }

  // 评论内容
  void replyComment(String message) {
    if (message == null || message.isEmpty) {
      TKToast.showToast('内容不能为空');
      return;
    }
    TKToast.showLoading();
    FindRequest.replyComment(message, _currentComment.commentId, _currentComment.userId).then((value) {
      if (value) {
        _editController.text = '';
        _onRefresh();
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }

  // 删除评论内容
  void deleteComment() {
    TKToast.showLoading();
    FindRequest.deleteComment(_currentComment.commentId).then((value) {
      if (value) {
        
        List<CommentModel> newModels = _commentList.where((element) => element.commentId != _currentComment.commentId).toList();
        setState(() { 
          _commentList = newModels;
        });
        _model.commentList = newModels;
        widget.actionCallBack(_model);
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }
}