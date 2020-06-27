import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/login/login.dart';
import 'package:mahua_pet/pages/discover/find_page.dart';
import 'package:mahua_pet/providered/model/model_index.dart';
import 'package:mahua_pet/providered/shared/shared_util.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'view_model/find_view_model.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  void initState() {
    super.initState();

    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('发现')),
        body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('登录'),
              onPressed: () => loginAction()
            ),
            RaisedButton(
              child: Text('消失'),
              onPressed: () => loginAction1()
            )
          ],
        )
      ),
    );
  }

  void loginAction() {
    Navigator.of(context).pushNamed(LoginPage.rooteName, arguments: 'main');
  }

  void loginAction1() {
    EasyLoading.dismiss();
  }
}