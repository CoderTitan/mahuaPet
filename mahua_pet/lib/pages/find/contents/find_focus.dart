
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mahua_pet/pages/find/contents/find_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import '../models/model_index.dart';
import '../views/find_item.dart';
import '../view_model/find_request.dart';




class FindFocusPage extends StatefulWidget {
  @override
  _FindFocusPageState createState() => _FindFocusPageState();
}

class _FindFocusPageState extends State<FindFocusPage> with AutomaticKeepAliveClientMixin {

  List<FocusModel> _focusArray = [];
  List<FocusPostModel> _postArray = [];
  int _postPage = 1;

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
      enablePullUp: FuncUtils.isLogin(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: CustomScrollView(
        slivers: <Widget>[
          renderFocusTitle(),
          renderFocusList(),
          renderPostList()
        ],
      )
    );
  }

  Widget renderFocusTitle() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.px),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('你可能想认识他们~', style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
                SmallButton(title: '换一组', width: 80.px, onPressed: () {
                  requestFocusList();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget renderFocusList() {
    return SliverToBoxAdapter(
      child: Container(
        color: TKColor.white,
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _focusArray.map((item) => renderFocusItem(item)).toList(),
          ),
        ),
      ),
    );
  }

  Widget renderFocusItem(FocusModel item) {
    final itemWidth = (SizeFit.screenWidth - (32 + 20).px) / 3;
    return Container(
      margin: EdgeInsets.only(right: 16.px),
      padding: EdgeInsets.all(10.px),
      constraints: BoxConstraints(minWidth: itemWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.px),
        border: Border.all(color: TKColor.color_e8e8e8, width: 0.5.px),
        color: TKColor.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TKNetworkImage(
            imageUrl: item.headImg,
            width: 50.px,
            height: 50.px,
            borderRadius: 30.px,
            placeholder: TKImages.image_path + 'user_header.png',
          ),
          SizedBox(height: 4.px),
          Container(
            height: 24.px, 
            child: Text(item.nickname, style: TextStyle(fontSize: 16.px, color: TKColor.color_333333))
          ),
          Container(
            height: 24.px, 
            child: Text(item.petBreed ?? '', style: TextStyle(fontSize: 13.px, color: TKColor.color_999999)),
          ),
          Container(
            height: 20.px, 
            child: Text('已有${item.relationNum}关注', style: TextStyle(fontSize: 10.px, color: TKColor.color_999999)),
          ),
          FocusButton(
            isSelect: item.isRelation ?? false,
            onPressed: () => requestFocusState(item)
          )
        ],
      ),
    );
  }

  Widget renderPostList() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.px),
      sliver: SliverList(delegate: SliverChildBuilderDelegate(
      (ctx, index) {
        final model = _postArray[index];
        return FindListItem(model: model, key: ValueKey(index), findCallBack: (type) => handleItemAction(type, model));
      },
      childCount: _postArray.length
    )),
    );
  }

  void _onRefresh() {
    requestFocusList();
    if (FuncUtils.isLogin()) {
      requestPostList(1);
    }
  }

  void _onLoading() {
    if (FuncUtils.isLogin()) {
      _postPage += 1;
      requestPostList(_postPage);
    }
  }

  void handleItemAction(FindActionType type, FocusPostModel model) {
    switch (type) {
      case FindActionType.header:
        print(FindActionType.header);
        break;
      case FindActionType.attation:
        requestPostAttation(model);
        break;
      case FindActionType.agree:
        requestAgreeState(model);
        break;
      case FindActionType.collection:
        TKRoute.push(context, FindDetailPage(messageId: model.messageId, actionCallBack: (model) => handleDataList(model)));
        break;
      case FindActionType.comment:
        TKRoute.push(context, FindDetailPage(messageId: model.messageId, actionCallBack: (model) => handleDataList(model)));
        break;
      case FindActionType.share:
        print(FindActionType.share);
        break;
      case FindActionType.detail:
        TKRoute.push(context, FindDetailPage(messageId: model.messageId, actionCallBack: (model) => handleDataList(model)));
        break;
      default:
    }
  }

  void handleDataList(DetailModel model) {
    List<FocusPostModel> newArr = _postArray.map((e) {
      FocusPostModel post = e;
      if (post.messageId == model.messageId) {
        post.agreeStatus = model.agreeStatus;
        post.cntAgree = model.cntAgree;
        post.cntComment = int.parse(model.commentNum);
        post.followStatus = model.followStatus;
      }
      return post;
    }).toList();

    List<FocusPostModel> postList = newArr.where((element) => element.followStatus == '关注').toList();
    setState(() {
      _postArray = postList;
    });
  }

  void requestFocusList() {
    FindRequest.requestRecomFocus().then((value) {
      setState(() {
        _focusArray = value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void requestPostList(pageIndex) {
    FindRequest.requestFocusPostList(pageIndex).then((value) {
      if (pageIndex == 1) {
        _postArray = value;
      } else {
        _postArray.addAll(value);
      }
      setState(() {});
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }).catchError((error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      print(error);
    });
  }

  // 关注列表--取消/关注
  void requestFocusState(FocusModel model) {
    TKToast.showLoading();
    FindRequest.requestFocus(model.isRelation, model.userId).then((value) {
      if (value) {
        if (!model.isRelation) {
          TKToast.showSuccess('关注成功');
        } else {
          TKToast.showSuccess('取消关注成功');
        }
        _focusArray.forEach((element) {
          if (element.userId == model.userId) {
            element.isRelation = !model.isRelation;
          }
        });
        setState(() { });
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }

  // 动态列表--关注
  void requestPostAttation(FocusPostModel model) {
    TKToast.showLoading();
    FindRequest.requestFocus(model.followStatus == '关注', model.userId)
      .then((value) {
        if (value) {
          if (model.followStatus != '关注') {
            TKToast.showSuccess('关注成功');
          } else {
            TKToast.showSuccess('取消关注成功');
          }
          List<FocusPostModel> newModels = _postArray.where((element) => element.userId != model.userId).toList();
          setState(() { 
            _postArray = newModels;
          });
        }
      }).catchError((error) {
        TKToast.dismiss();
        print(error);
      });
  }

  // 点赞
  void requestAgreeState(FocusPostModel model) {
    TKToast.showLoading();
    FindRequest.requestAgree(model.agreeStatus == '0', messageId: model.messageId).then((value) {
      if (value) {
        if (model.agreeStatus == '0') {
          model.cntAgree = model.cntAgree + 1;
          TKToast.showSuccess('点赞成功');
        } else {
          model.cntAgree = model.cntAgree - 1;
          TKToast.showSuccess('取消点赞成功');
        }
        _postArray.forEach((element) {
          if (element.userId == model.userId) {
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
}