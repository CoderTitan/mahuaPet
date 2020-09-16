import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mahua_pet/providered/shared/shared_storage.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'styles/app_style.dart';
import 'redux_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedStorage.initData().then((value) {
    runApp(MyApp());
  }).catchError((error) {
    print(error);
  });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SizeFit.initialize();
    TKDeviceInfo.initialezed();
    

    return FlutterReduxApp();
  }
}
