import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/contents/find_focus.dart';
import 'package:mahua_pet/pages/find/contents/find_nearby.dart';
import 'package:mahua_pet/pages/find/contents/find_recom.dart';

import 'package:mahua_pet/styles/app_style.dart';


class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with SingleTickerProviderStateMixin {

  List<String> tabs = ['关注', '推荐', '附近'];
  List<Widget> tabViews = [FindFocusPage(), FindRecomPage(), FindNearbyPage()];
  TabController _tabController ;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          isScrollable: true,
          indicatorColor: TKColor.color_1a1a1a,
          indicatorWeight: 2.5.px,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: TKColor.color_1a1a1a,
          unselectedLabelColor: TKColor.color_666666,
          labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabViews.map((e) => e).toList(),
      )
    );
  }
}

