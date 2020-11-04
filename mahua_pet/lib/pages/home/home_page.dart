
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/generated/l10n.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'views/view_index.dart';
import 'contents/content_index.dart';



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
  final  List<String> tabs = [S.current.mine_flower, S.current.mine_flower];

  bool isScrollTop = false;
  ScrollController _scrollController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
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
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(),
              HomeHeader(scrollTop: isScrollTop),
              renderCalendarHeader(context, store),
              renderListHeader(store),
            ];
          }, 
          body: TabBarView(
            controller: _tabController,
            children: [
              HomeGressContent(),
              HomeRecommend()
            ]
          )
        );
      },
    );
  }

  Widget renderCalendarHeader(BuildContext context, Store store) {
    PetModel currentPet = store.state.currentPet ?? PetModel();
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 18.px,
            icon: Image.asset('${TKImages.image_path}calendar.png', color: store.state.isNightModal ? TKColor.color_edf2fa : TKColor.color_1a1a1a), 
            onPressed: () {
              TKRoute.push(context, CalendarPage(petId: currentPet.petId));
            }
          )
        ],
      ),
    );
  }

  Widget renderListHeader(Store store) {
    final isNight = store.state.isNightModal ?? false;
    final mainColor = store.state.themeData.primaryColor;
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        isNight: isNight,
        child: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          isScrollable: false,
          indicatorColor: isNight ? TKColor.white : mainColor,
          indicatorWeight: 2.px,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: TKColor.blackColor(isNight),
          unselectedLabelColor: TKColor.lightGray(isNight),
          labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
        )
      ),
    );
  }
}