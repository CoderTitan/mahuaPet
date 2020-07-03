import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/pages/login/login.dart';
import 'package:mahua_pet/pages/discover/find_page.dart';
import 'package:mahua_pet/providered/model/model_index.dart';
import 'package:mahua_pet/providered/shared/shared_util.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:provider/provider.dart';
import 'view_model/find_view_model.dart';




final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];



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
              onPressed: () => loginAction(context)
            ),
            renderSwiper(),
          ],
        )
      ),
    );
  }

  Widget renderSwiper() {
    return CarouselSlider(
      items: imgList.map((item) => Container(
        child: Center(
          child: Image.network(item)
        ),
        color: Colors.green,
      )).toList(), 
      options: CarouselOptions(
        height: 200.px,
        
      )
    );
  }

  void loginAction(BuildContext context) {
    FuncUtils.loginOut(context);
  }

  void loginAction1() {
    EasyLoading.dismiss();
  }
}