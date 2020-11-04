import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mahua_pet/pages/find/models/recommend_model.dart';
import 'package:mahua_pet/pages/find/views/find_recom_item.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/grass_model.dart';
import '../request/home_request.dart';


class HomeRecommend extends StatefulWidget {
  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> with AutomaticKeepAliveClientMixin {

  List<RecommendModel> modelList = [];
  int pageIndex = 1;
  bool showLoading = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { 
    super.initState();
    
    if (FuncUtils.isLogin()) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (modelList.length == 0) {
      return EmptyContent(
        showReload: FuncUtils.isLogin(),
        offsetY: 32.px,
        onPressed: refreshData,
      );
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: refreshData,
      onLoading: loadMoreData,
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8.px),
        crossAxisCount: 2,
        mainAxisSpacing: 8.px,
        crossAxisSpacing: 8.px,
        itemCount: modelList.length,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return FindRecomItem(key: ValueKey(index), recomModel: modelList[index]);
        },
      ),
    );
  }

  void refreshData() {
    requestGrass(1);
  }

  void loadMoreData() {
    if (showLoading) {
      TKToast.showLoading();
    }
    showLoading = true;
    pageIndex += 1;
    requestGrass(pageIndex);
  }

  void requestGrass(int pageIndex) {
    HomeRequest.requestHomeRecomList(pageIndex).then((value) {
      TKToast.dismiss();
      showLoading = false;
      List<RecommendModel> models = value ?? [];
      if (pageIndex == 1) {
        modelList = models;
      } else {
        modelList.addAll(models);
      }
      setState(() {});

      _refreshController.refreshCompleted();
      if (models.length > 10) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    }).catchError((error) {
      TKToast.dismiss();
      showLoading = false;
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }); 
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}