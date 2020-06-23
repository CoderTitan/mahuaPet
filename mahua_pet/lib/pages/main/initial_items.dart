
import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/home/home_page.dart';
import 'package:mahua_pet/pages/discover/discover_page.dart';
import 'package:mahua_pet/pages/college/college_page.dart';
import 'package:mahua_pet/pages/mine/mine_page.dart';

import 'package:mahua_pet/styles/app_images.dart';


final List<Widget> pageList = [
  HomePage(),
  DiscoverPage(),
  CollegePage(),
  CollegePage(),
  MinePage()
];


final List<BottomNavigationBarItem> itemList = [
  BottomNavigationBarItem(
    title: Text("首页"),
    activeIcon: Image.asset(TKImages.tabbar_home_select, fit: BoxFit.contain),
    icon: Image.asset(TKImages.tabbar_home_unselect, fit: BoxFit.contain)
  ),
  BottomNavigationBarItem(
    title: Text("发现"),
    activeIcon: Image.asset(TKImages.tabbar_find_select, fit: BoxFit.contain),
    icon: Image.asset(TKImages.tabbar_find_unselect, fit: BoxFit.contain)
  ),
  BottomNavigationBarItem(
    title: Container(),
    icon: Image.asset(TKImages.tabbar_add, fit: BoxFit.contain),
  ),
  BottomNavigationBarItem(
    title: Text("学院"),
    activeIcon: Image.asset(TKImages.tabbar_school_select, fit: BoxFit.contain),
    icon: Image.asset(TKImages.tabbar_school_unselect, fit: BoxFit.contain)
  ),
  BottomNavigationBarItem(
    title: Text("我的"),
    activeIcon: Image.asset(TKImages.tabbar_mine_select, fit: BoxFit.contain),
    icon: Image.asset(TKImages.tabbar_mine_unselect, fit: BoxFit.contain)
  ),
];