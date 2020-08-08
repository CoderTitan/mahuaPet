import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/func_utils.dart';
import 'package:provider/provider.dart';
import 'mine_view_model.dart';

import 'package:cached_network_image/cached_network_image.dart';


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
            ),
            SizedBox(height: 30.px,),
            GestureDetector(
              child: Hero(
                tag: 'mine-hero-png', 
                child: Image.network('https://titanjun.oss-cn-hangzhou.aliyuncs.com/flutter/flutter_scroll.png', width: 100, height: 100,)
              ),
              onTap: () {
                showPhoto(context);
              },
            )
          ],
        )
      ),
    );
  }

  void showPhoto(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) {
        return Scaffold(
          body: Center(
            child: Hero(
              tag: 'mine-hero-png', 
              child: Image.network('https://titanjun.oss-cn-hangzhou.aliyuncs.com/flutter/flutter_scroll.png', width: 200, height: 200,)
            ),
          ),
        );
      })
    );
  }
}





