
import 'package:flutter/material.dart';
import 'initial_items.dart';
import 'package:mahua_pet/styles/app_colors.dart';

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
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: TKColor.main_color,
        unselectedItemColor: Colors.black38,
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(fontSize: 10, color: TKColor.main_color),
        unselectedLabelStyle: TextStyle(fontSize: 10, color: TKColor.main_color),
        onTap: (index) {
          if (index == 2) { return; }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
