
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/generated/l10n.dart';

import 'package:mahua_pet/pages/find/models/model_index.dart';
import 'package:mahua_pet/pages/find/view_model/view_model_index.dart';
import 'package:mahua_pet/pages/find/views/find_recom_swiper.dart';
import 'views/view_index.dart';
import 'contents/content_index.dart';
import 'models/model_index.dart';
import 'request/home_request.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFit.screenHeight,
      child: HomeContent(),
    );
  }
}


class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {

  final double flexHeaderHeight = 210.px + SizeFit.statusHeight;
  final  List<String> tabs = ['种草', '推荐'];
  List<Widget> tabViews;

  List<GrassModel> grassList;
  // List<GrassModel> grassList;
  int grassPage = 1;
  // int grassPage = 1;
  bool showLoading = false;

  bool isScrollTop = false;
  List<FindTopicModel> _topicList = [];
  int tabIndex = 0;
  TabController _tabController ;
  ScrollController _scrollController = ScrollController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    final double _marginHeight = flexHeaderHeight - 56.px;
    _scrollController.addListener(() {
      if (_scrollController.offset > _marginHeight && !isScrollTop) {
        setState(() {
          isScrollTop = true;
        });
      } else if (_scrollController.offset < _marginHeight && isScrollTop) {
        setState(() {
          isScrollTop = false;
        });
      }
    });
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
    _tabController.addListener(() {
      tabIndex = _tabController.index;
    });

    if (FuncUtils.isLogin()) {
      _refreshAction();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: _refreshAction,
          onLoading: _loadAction,
          child: CustomScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverToBoxAdapter(),
              HomeHeader(scrollTop: isScrollTop),
              renderCalendarHeader(context, store),
              renderSwiperList(),
              renderListHeader(),
              renderListContent(),
            ],
          ),
          // child: NestedScrollView(
          //   headerSliverBuilder: (ctx, innerBoxIsScrolled) {
          //     return <Widget>[
          //       SliverToBoxAdapter(),
          //       HomeHeader(scrollTop: isScrollTop),
          //       renderCalendarHeader(context, store),
          //       renderSwiperList(),
          //       renderListHeader(),
          //       // renderListContent(),
          //     ];
          //   }, 
          //   body: TabBarView(
          //     controller: _tabController,
          //     children: [
          //       StaggeredGridView.countBuilder(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 8.px,
          //         crossAxisSpacing: 8.px,
          //         itemCount: grassList.length,
          //         staggeredTileBuilder: (_) => StaggeredTile.fit(1),
          //         itemBuilder: (context, index) {
          //           return HomeGridItem(key: ValueKey(index), model: grassList[index]);
          //         },
          //       ),
          //       Container()
          //     ]
          //   )
          // ),
        );
      },
    );
  }

  Widget renderCalendarHeader(BuildContext context, Store store) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 18.px,
            icon: Image.asset('${TKImages.image_path}calendar.png', color: store.state.isNightModal ? TKColor.color_edf2fa : TKColor.color_1a1a1a), 
            onPressed: () {
              Navigator.of(context).pushNamed(CalendarPage.routeName);
            }
          )
        ],
      ),
    );
  }

  Widget renderSwiperList() {
    if (_topicList.length == 0) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(
      child: FindTopicSwiper(topics: _topicList),
    ); 
  }

  Widget renderListHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          isScrollable: false,
          indicatorColor: TKColor.main_color,
          indicatorWeight: 2.px,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: TKColor.color_1a1a1a,
          unselectedLabelColor: TKColor.color_666666,
          labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
        )
      ),
    );
  }

  Widget renderListContent() {
    return SliverToBoxAdapter(
      child: TabBarView(
        controller: _tabController,
        children: [
          StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 8.px,
            crossAxisSpacing: 8.px,
            itemCount: grassList.length,
            staggeredTileBuilder: (_) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return HomeGridItem(key: ValueKey(index), model: grassList[index]);
            },
          ),
          // StaggeredGridView.countBuilder(
          //   crossAxisCount: 2,
          //   mainAxisSpacing: 8.px,
          //   crossAxisSpacing: 8.px,
          //   itemCount: grassList.length,
          //   staggeredTileBuilder: (_) => StaggeredTile.fit(1),
          //   itemBuilder: (context, index) {
          //     return HomeGridItem(key: ValueKey(index), model: grassList[index]);
          //   },
          // )
          Container()
        ],
      ),
    );
  }

  void _refreshAction() {
    if (tabIndex == 0) {
      requestGrass(1);
    } else {
      // requestGrass(1);
    }

    FindRequest.requestTopicList().then((value) {
      setState(() {
        _topicList = value;
      });
      _refreshController.refreshCompleted();
    });
  }

  void _loadAction() {
    if (tabIndex == 0) {
      grassPage ++;
      requestGrass(grassPage);
    } else {
      // requestGrass(1);
    }
  }

  void requestGrass(int pageIndex) {
    HomeRequest.requestHomeGrass(pageIndex).then((value) {
      TKToast.dismiss();
      showLoading = false;
      List<GrassModel> models = value ?? [];
      if (pageIndex == 1) {
        grassList = models;
      } else {
        grassList.addAll(models);
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
}