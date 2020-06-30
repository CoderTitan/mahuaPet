import 'package:flutter/material.dart';
import 'package:mahua_pet/utils/func_utils.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
        body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              elevation: 16,
              child: Text('退出登录'),
              onPressed: (){  
                FuncUtils.loginOut(context);
              }
            )
          ],
        )
      ),
    );
  }
}