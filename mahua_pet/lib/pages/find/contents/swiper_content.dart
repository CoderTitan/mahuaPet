
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import '../models/model_index.dart';
import '../view_model/view_model_index.dart';
import '../views/find_recom_item.dart';

class SwiperContent extends StatefulWidget {

  /// 最热:1, 最新:2
  final int orderType;
  final FindTopicModel swiper;
  SwiperContent({Key key, this.orderType, this.swiper}): super(key: key);

  @override
  _SwiperContentState createState() => _SwiperContentState();
}

class _SwiperContentState extends State<SwiperContent> with AutomaticKeepAliveClientMixin{

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<RecommendModel> _modelList = [];
  int _pageIndex = 1;
  bool _showLoading = false;


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    requestCommentList(1);
  } 

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: _onLoading,
      child: CustomScrollView(
        slivers: [
          renderPullList()
        ],
      )
    );
  }

  Widget renderPullList() {
    if (_modelList.length == 0) {
      return SliverToBoxAdapter(
        child: EmptyContent(),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.px),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 8.px,
        crossAxisSpacing: 8.px,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return FindRecomItem(key: ValueKey(index), recomModel: _modelList[index]);
        },
        itemCount: _modelList.length,
      ),
    );
  }

  void _onLoading() {
    if (_showLoading) {
      TKToast.showLoading();
    }
    _showLoading = true;
    _pageIndex += 1;
    requestCommentList(_pageIndex);
  }

  void requestCommentList(pageIndex) {
    final _model = widget.swiper;
    _showLoading = true;
    FindRequest.requestTolkList(_model.labelId, widget.orderType, pageIndex).then((value) {
      TKToast.dismiss();
      _showLoading = false;
      if (pageIndex == 1) {
        _modelList = value;
        _refreshController.refreshCompleted();
        if (value.length > 0) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        _modelList.addAll(value);
        if (value.length > 0) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      }
      setState(() {});
    }).catchError((error) {
      TKToast.dismiss();
      _showLoading = false;
      _refreshController.refreshFailed();
      _refreshController.loadFailed();
      print(error);
    });
  }
}