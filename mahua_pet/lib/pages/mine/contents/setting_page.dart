import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Scaffold(
          appBar: AppBar(title: Text('设置')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.px),
                LargeButton(
                  title: '退出登录',
                  disabled: true,
                  onPressed: () {
                    TKActionAlert.showAlert(
                      context: ctx, 
                      message: '确认退出登录?',
                      rightTitle: '确认',
                      rightPressed: () {
                        FuncUtils.loginOutAction(context);
                      }
                    );
                  }
                ),
                SizedBox(height: 16.px)
              ],
            ),
          ),
        );
      },
    );
  }

  
}