import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/pages/find/contents/find_focus.dart';
import 'package:mahua_pet/pages/find/contents/find_topic.dart';
import 'package:mahua_pet/pages/find/contents/find_recom.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/redux/redux_index.dart';



class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with SingleTickerProviderStateMixin {

  List<String> tabs = [S.current.mine_flower, S.current.find_recom, S.current.find_topic];
  List<Widget> tabViews = [FindFocusPage(), FindRecomPage(), FindTopicPage()];
  TabController _tabController ;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        tabs = [S.of(context).mine_flower, S.of(context).find_recom, S.of(context).find_topic];
        return Scaffold(
          appBar: AppBar(
            title: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
              isScrollable: true,
              indicatorColor: TKColor.white,
              indicatorWeight: 2.5.px,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: TKColor.blackColor(true),
              unselectedLabelColor: TKColor.grayColor(true),
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
      },
    );
  }
}

