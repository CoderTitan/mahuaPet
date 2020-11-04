import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';

import '../models/grass_model.dart';
import '../views/home_grid_item.dart';
import '../request/home_request.dart';
import 'grass_detail.dart';


class HomeGressContent extends StatefulWidget {
  @override
  _HomeGressContentState createState() => _HomeGressContentState();
}

class _HomeGressContentState extends State<HomeGressContent> with AutomaticKeepAliveClientMixin {


  List<GrassModel> modelList = [];
  int pageIndex = 1;
  bool showLoading = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { 
    super.initState();
    
    if (FuncUtils.isLogin()){
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (modelList.length == 0) {
      return EmptyContent(
        showReload: FuncUtils.isLogin(),
        offsetY: 16.px,
        onPressed: () {
          refreshData();
        },
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
          final model = modelList[index];
          return HomeGridItem(key: ValueKey(index), model: model, actionCallBack: (grass) {
            TKRoute.push(context, GrassDetail(trialId: model.trialReportId, callback: (grassModel) {
              updateDatas(grassModel);
            }));
          });
        },
      ),
    );
  }

  void updateDatas(GrassModel grass) {
    var tmpList = modelList.map((e) {
      if (e.trialReportId == grass.trialReportId) {
        e.agreeStatus = grass.agreeStatus;
        e.messageAgreenum = grass.messageAgreenum;
      }
      return e;
    }).toList();
    setState(() {
      modelList = tmpList;
    });
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
    HomeRequest.requestHomeGrass(pageIndex).then((value) {
      TKToast.dismiss();
      showLoading = false;
      List<GrassModel> models = value ?? [];
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