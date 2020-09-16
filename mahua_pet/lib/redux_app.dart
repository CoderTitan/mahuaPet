
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/config/config_index.dart';


class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> with NavigatorObserver {
  
  /// 初始化state
  final store = Store<TKState>(
    appReducer,
    initialState: TKState(
      themeData: ThemeData(primarySwatch: TKColor.main_color)
    ),
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      /*
      通过 with NavigatorObserver ，在这里可以获取到
      MaterialApp 和 StoreProvider 的 context
      还可以获取到 navigator;
      比如在这里增加一个监听，如果 token 失效就退回登陆页。
      */
      
      navigator.context;
      navigator;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<TKState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance.window.locale;
          FuncUtils.initThemeData(store);
          return TKMainConfig(
            child: MaterialApp(
              title: '麻花宠物',
              theme: store.state.themeData,
              initialRoute: TKRoute.initialRoute,
              onGenerateRoute: TKRoute.generateRoute,
              onUnknownRoute: TKRoute.unknownRoute,
              routes: TKRoute.routeList,
              debugShowCheckedModeBanner: false,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver(), this],
            ),
          );
        },
      ),
    );
  }
}

