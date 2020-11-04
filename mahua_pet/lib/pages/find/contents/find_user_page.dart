import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';

import '../views/find_user_header.dart';

typedef FindUserPageCallBack = void Function(String focusState);

class FindUserPage extends StatefulWidget {

  final int userId;
  final FindUserPageCallBack actionCallBack;
  FindUserPage({this.userId, this.actionCallBack});

  @override
  _FindUserPageState createState() => _FindUserPageState();
}

class _FindUserPageState extends State<FindUserPage> with SingleTickerProviderStateMixin {

  List<String> tabs = ['动态', '种草', '提问', '回答'];
  TabController _tabController ;

  UserData _userData = UserData();

  @override
  void initState() { 
    super.initState();
    
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
    requestUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final nickname = _userData.userinfo == null ? '' : _userData.userinfo.nickname;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title: nickname,
              collapsedHeight: 44,
              expandedHeight: 300,
              paddingTop: MediaQuery.of(context).padding.top,
              child: FindUserHeaer(userData: _userData)
            ),
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
                labelColor: TKColor.color_1a1a1a,
                unselectedLabelColor: TKColor.color_666666,
                labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
              )
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              // children: tabViews.map((e) => e).toList(),
              children: tabs.map((e) {
                if (e == '动态') {
                  return Container();
                }
                return EmptyContent();
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  void requestUserInfo() {
    PointRequest.requestUser(widget.userId).then((value) {
      setState(() {
        _userData = value;
      });
    }).catchError((error) {
      TKToast.dismiss();
    });
  }
}


