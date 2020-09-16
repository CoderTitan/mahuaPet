import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:bot_toast/bot_toast.dart';


class CollegePage extends StatefulWidget {
  CollegePage({Key key}) : super(key: key);

  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学院')),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              
            ],
          )
        )
    );
  }

  void showToast() {
    
  }
}
