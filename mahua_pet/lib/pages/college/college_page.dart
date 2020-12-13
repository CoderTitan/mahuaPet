import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:ui' as ui;
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/college/college_test.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';


class CollegePage extends StatefulWidget {
  CollegePage({Key key}) : super(key: key);

  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学院')),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(icon: Icon(Icons.access_alarm), onPressed: () {

                
              }),
              PopupMenuButton<String>(
                child: Text('数学'),
                initialValue: '语文',
                itemBuilder: (ctx) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: '语文',
                      child: Text('语文'),
                    ),
                    PopupMenuItem<String>(
                      value: '数学',
                      child: Text('数学'),
                    ),
                    PopupMenuItem<String>(
                      value: '英语',
                      child: Text('英语'),
                    ),
                    PopupMenuItem<String>(
                      value: '生物',
                      child: Text('生物'),
                    ),
                  ];
                },
              ),
            ],
          )
        )
    );
  }

  void showToast() {
    
  }
}
