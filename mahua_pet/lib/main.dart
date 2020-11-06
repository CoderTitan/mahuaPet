import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/component/toast_show.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'styles/app_style.dart';
import 'redux_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  

  SharedStorage.initStorage().then((value) {
    runApp(MyApp());
    TKToast.setToastStyle();
  }).catchError((error) {
    print(error);
  });
  
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SizeFit.initialize();
    TKDeviceInfo.initialezed();
    

    return ReduxApp();
  }
}