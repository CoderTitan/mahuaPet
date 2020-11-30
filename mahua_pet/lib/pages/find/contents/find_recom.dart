
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mahua_pet/providered/provider/consume_provider.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/component/component.dart';

import '../view_model/view_model_index.dart';
import '../views/find_recom_swiper.dart';
import '../views/find_recom_item.dart';



class FindRecomPage extends StatefulWidget {
  @override
  _FindRecomPageState createState() => _FindRecomPageState();
}

class _FindRecomPageState extends State<FindRecomPage> with AutomaticKeepAliveClientMixin {

  FindRecommendProvider _recommendVM;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return ConsumerProvider<FindRecommendProvider>(
          model: FindRecommendProvider(),
          onModelReady: (recomVM) {
            if (FuncUtils.isLogin()) {
              recomVM.initDatas();
            }
          },
          builder: (_, recomVM, child) {
            _recommendVM = recomVM;
            return SmartRefresher(
              controller: recomVM.refreshController,
              enablePullUp: FuncUtils.isLogin(),
              onRefresh: () {
                if (FuncUtils.isLogin()) {
                  recomVM.refreshData();
                  recomVM.showErrorMessage(context);
                } else {
                  recomVM.refreshController.refreshCompleted();
                }
              },
              onLoading: recomVM.loadMoreData,
              child: CustomScrollView(
                slivers: <Widget>[
                  renderTopicItems(),
                  renderPullList(),
                ],
              )
            );
          },
        );
      },
    );
  }

  Widget renderTopicItems() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      sliver: SliverToBoxAdapter(
        child: FindTopicSwiper(topics: _recommendVM.topicArray),
      ),
    );
  }

  Widget renderPullList() {
    if (_recommendVM.isBusy) {
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
          return FindRecomItem(key: ValueKey(index), recomModel: _recommendVM.list[index]);
        },
        itemCount: _recommendVM.list.length,
      ),
    );
  }

}

