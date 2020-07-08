
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';

import '../view_model/find_request.dart';
import '../models/model_index.dart';
import '../views/find_recom_swiper.dart';
import '../views/find_recom_item.dart';



class FindRecomPage extends StatefulWidget {
  @override
  _FindRecomPageState createState() => _FindRecomPageState();
}

class _FindRecomPageState extends State<FindRecomPage> {

  List<FindTopicModel> _topicArray = [];
  List<RecommendModel> _postArray = [];
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
          renderTopicItems(),
          renderPullList(),
          // renderPostList()
        ],
      )
    );
  }

  Widget renderTopicItems() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      sliver: SliverToBoxAdapter(
        child: FindTopicSwiper(topics: _topicArray),
      ),
    );
  }

  Widget renderPullList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.px),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 8.px,
        crossAxisSpacing: 8.px,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (context, index) => FindRecomItem(model: _postArray[index]),
        itemCount: _postArray.length,
      ),
    );
  }


  void _onRefresh() {
    requestTopicList();
    if (FuncUtils.isLogin()) {
      requestCommendList(1);
    }
  }

  void _onLoading() {
    if (FuncUtils.isLogin()) {
      _postPage += 1;
      requestCommendList(_postPage);
    }
  }

  void requestTopicList() {
    FindRequest.requestTopicList().then((value) {
      setState(() {
        _topicArray = value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void requestCommendList(int pageIndex) {
    FindRequest.requestRecommendList(pageIndex).then((value) {
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

