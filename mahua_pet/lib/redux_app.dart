import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:mahua_pet/generated/l10n.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';

import 'package:mahua_pet/flutter_widget/widget/list_items.dart';

class ReduxApp extends StatefulWidget {
  @override
  _ReduxAppState createState() => _ReduxAppState();
}

class _ReduxAppState extends State<ReduxApp> with NavigatorObserver {

  /// 初始化state
  final store = Store<TKState>(
    appReducer,
    middleware: middleware,
    initialState: TKState(
      themeData: FuncUtils.getThemeData(0),
      locale: Locale('zh', 'CH'),
      isNightModal: false,
      isLogin: false,
    ),
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      navigator.context;
      navigator;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWelcome = SharedStorage.showWelcome;
    return StoreProvider(
      store: store,
      child: StoreBuilder<TKState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance.window.locale;
          Map<String, WidgetBuilder> routeArr = TKRoute.routeList;
          routeArr.addAll(routeLists);
          return TKMainConfig(
            child: MaterialApp(
              title: '麻花宠物',
              theme: store.state.themeData,
              supportedLocales: [store.state.locale],
              locale: store.state.locale,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                S.delegate
              ],
              initialRoute: isWelcome ? TKRoute.launchRoute : TKRoute.welcomeRoute,
              onGenerateRoute: TKRoute.generateRoute,
              onUnknownRoute: TKRoute.unknownRoute,
              routes: routeArr,
              debugShowCheckedModeBanner: false,
              navigatorObservers: [this],
              builder: (ctx, child) {
                return FlutterEasyLoading(child: child);
              },
            ),
          );
        },
      ),
    );
  }
}