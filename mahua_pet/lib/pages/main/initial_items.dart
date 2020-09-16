
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:mahua_pet/pages/college/college_page.dart';
import 'package:mahua_pet/pages/home/home_page.dart';
import 'package:mahua_pet/pages/find/find_page.dart';
import 'package:mahua_pet/pages/mine/mine_page.dart';
import 'package:mahua_pet/styles/app_colors.dart';

import 'package:mahua_pet/styles/app_images.dart';


final List<Widget> pageList = [
  HomePage(),
  FindPage(),
  Container(),
  CollegePage(),
  MinePage()
];

void test() {

}


List<BottomNavigationBarItem> itemList(Store store) {
  return [
    BottomNavigationBarItem(
      title: Text("首页"),
      // activeIcon: Image.asset(TKImages.tabbar_home_select, fit: BoxFit.contain),
      // icon: Image.asset(TKImages.tabbar_home_unselect, fit: BoxFit.contain)
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      title: Text("发现"),
      // activeIcon: Image.asset(TKImages.tabbar_find_select, fit: BoxFit.contain),
      // icon: Image.asset(TKImages.tabbar_find_unselect, fit: BoxFit.contain)
      icon: Icon(Icons.insert_invitation),
    ),
    BottomNavigationBarItem(
      title: Container(),
      // icon: Image.asset(TKImages.tabbar_add, fit: BoxFit.contain),
      icon: Icon(Icons.add_circle, size: 44, color: store.state.isNightModal ? TKColor.white : store.state.themeData.primaryColor),
    ),
    BottomNavigationBarItem(
      title: Text("话题"),
      // activeIcon: Image.asset(TKImages.tabbar_school_select, fit: BoxFit.contain),
      // icon: Image.asset(TKImages.tabbar_school_unselect, fit: BoxFit.contain)
      icon: Icon(Icons.chrome_reader_mode),
    ),
    BottomNavigationBarItem(
      title: Text("我的"),
      // activeIcon: Image.asset(TKImages.tabbar_mine_select, fit: BoxFit.contain),
      // icon: Image.asset(TKImages.tabbar_mine_unselect, fit: BoxFit.contain)
      icon: Icon(Icons.person),
    ),
  ];
}