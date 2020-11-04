import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'swiper_content.dart';



class FindSwiperPage extends StatefulWidget {
  final FindTopicModel model;

  FindSwiperPage({this.model});

  @override
  _FindSwiperPageState createState() => _FindSwiperPageState();
}

class _FindSwiperPageState extends State<FindSwiperPage> with SingleTickerProviderStateMixin {

  List<String> tabs = ['热门', '最新'];
  TabController _tabController ;

  @override
  void initState() { 
    super.initState();
    
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model.labelName)),
      body: NestedScrollView(
        headerSliverBuilder: (ctx, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: renderHeaderItem(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                isNight: false,
                child: TabBar(
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                  isScrollable: false,
                  indicatorColor: TKColor.main_color,
                  indicatorWeight: 2.px,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: TKColor.main_color,
                  unselectedLabelColor: TKColor.color_666666,
                  labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                  labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
                )
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return SwiperContent(
              key: ValueKey(e), 
              orderType: e == '热门' ? 1 : 2,
              swiper: widget.model,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget renderHeaderItem() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border.fromBorderSide(BorderSide(color: TKColor.color_e8e8e8, width: 0.5))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: SizeFit.screenWidth - 32.px,
              padding: EdgeInsets.all(16.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('#${widget.model.labelName}#', style: TextStyle(fontSize: 16.px, color: TKColor.color_1a1a1a)),
                  Text('//  ${widget.model.userCount}人参与了话题  //', style: TextStyle(fontSize: 12.px, color: TKColor.color_999999)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.px),
          Text(widget.model.labelDesc, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
        ],
      ),
    );
  }
}