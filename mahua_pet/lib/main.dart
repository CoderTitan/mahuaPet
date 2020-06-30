import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:mahua_pet/providered/provider/provider_config.dart';
import 'package:mahua_pet/providered/shared/shared_storage.dart';
import 'utils/router.dart';
import 'styles/app_style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedStorage.init().then((value) {
    runApp(
      MultiProvider(
        providers: ProviderConfig.providers,
        child: MyApp(),
      )
    );
  }).catchError((error) {
    runApp(
        MultiProvider(
          providers: ProviderConfig.providers,
          child: MyApp(),
        )
    );
  });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SizeFit.initialize();

    return FlutterEasyLoading(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: TKTheme.lightTheme,
        initialRoute: TKRoute.initialRoute,
        onGenerateRoute: TKRoute.generateRoute,
        onUnknownRoute: TKRoute.unknownRoute,
        routes: TKRoute.routeList,
      )
    );
  }
}

// Future<void> main() async {
//       WidgetsFlutterBinding.ensureInitialized();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var email = prefs.getString('email');
//       print(email);
//       runApp(MaterialApp(home: email == null ? Login() : Home()));
//     }