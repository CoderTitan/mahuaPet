import 'package:flutter/material.dart';

import 'untils/router.dart';
import 'styles/app_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SizeFit.initialize();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: TKTheme.lightTheme,
      initialRoute: TKRoute.initialRoute,
      onGenerateRoute: TKRoute.generateRoute,
      onUnknownRoute: TKRoute.unknownRoute,
      routes: TKRoute.routeList,
    );
  }
}
