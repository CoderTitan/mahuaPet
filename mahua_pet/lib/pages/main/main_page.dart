
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_colors.dart';
import 'package:mahua_pet/component/component.dart';

import 'initial_items.dart';

class MainPage extends StatefulWidget {

  // 初始路由
  static const String routerName = '/';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: TKColor.whiteColor(store.state.isNightModal),
            items: itemList(store),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: store.state.isNightModal ? TKColor.white : store.state.themeData.primaryColor,
            unselectedItemColor: TKColor.grayColor(store.state.isNightModal),
            selectedIconTheme: IconThemeData(size: 24, color: store.state.isNightModal ? TKColor.white : store.state.themeData.primaryColor),
            unselectedIconTheme: IconThemeData(size: 24, color: TKColor.grayColor(store.state.isNightModal)),
            onTap: (index) {
              if (index == 2) { 
                TKActionSheet.bottomSheet(context, GrowthAlert());
                return;
              }
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
