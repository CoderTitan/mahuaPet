
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/pages/find/models/focus_model.dart';
import 'package:mahua_pet/pages/find/models/focus_post_model.dart';
import 'package:mahua_pet/styles/app_style.dart';
import '../views/find_item.dart';
import '../view_model/find_request.dart';




class FindFocusPage extends StatefulWidget {
  @override
  _FindFocusPageState createState() => _FindFocusPageState();
}

class _FindFocusPageState extends State<FindFocusPage> {

  List<FocusModel> _focusArray = [];
  List<FocusPostModel> _postArray = [];
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
    final itemWidth = (SizeFit.screenWidth - (32 + 20).px) / 3;
    return SliverToBoxAdapter(
      child: Container(
        color: TKColor.white,
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
        child: Wrap(
          spacing: 10.px,
          children: _focusArray.map((item) {
            return Container(
              width: itemWidth,
              padding: EdgeInsets.all(10.px),
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
                  Text(item.nickname, style: TextStyle(fontSize: 16.px, color: TKColor.color_333333, height: 1.3)),
                  Text(item.petBreed ?? '关注', style: TextStyle(fontSize: 14.px, color: TKColor.color_999999)),
                  Text('已有${item.relationNum}关注', style: TextStyle(fontSize: 10.px, color: TKColor.color_999999)),
                  SizedBox(height: 8.px),
                  GestureDetector(
                    child: Container(
                      width: 60.px,
                      height: 20.px,
                      decoration: BoxDecoration(
                        color: (item.isRelation ?? false) ? TKColor.color_ffea9e_33 : TKColor.main_color,
                        borderRadius: BorderRadius.circular(20.px),
                        border: Border.all(color: TKColor.main_color, width: 0.5)
                      ),
                      child: Center(child: Text('+关注', style: TextStyle(
                        fontSize: 12.px, 
                        color: (item.isRelation ?? false) ? TKColor.main_color : TKColor.white
                      )))
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget renderPostList() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.px),
      sliver: SliverList(delegate: SliverChildBuilderDelegate(
      (ctx, index) {
        final model = _postArray[index];
        return FindListItem(index, model, ValueKey(index));
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

  void requestFocusList() {
    FindRequest.requestRecomFocus().then((value) {
      setState(() {
        _focusArray = value.length > 3 ? value.sublist(0, 3) : value;
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
}