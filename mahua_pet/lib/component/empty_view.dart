import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';



/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}


/// 无数据
class EmptyContent extends StatelessWidget {

  final String image;
  final String title;
  final double offsetY;
  final bool showReload;
  final VoidCallback onPressed;

  EmptyContent({
    this.image = TKImages.empty_data,
    this.title,
    this.offsetY = 200,
    this.showReload = true,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeFit.screenWidth,
      height: SizeFit.screenHeight,
      padding: EdgeInsets.only(left: 32.px, right: 32.px, top: offsetY),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: renderItems(context),
      ),
    );
  }

  List<Widget> renderItems(BuildContext context) {
    List<Widget> itemList = [];

    final message = title ?? S.of(context).empty_data;

    Widget imageItem = Image.asset(image, fit: BoxFit.contain, width: 150.px, height: 150.px);
    itemList.add(imageItem);

    Widget titleItem = Text(message, style: TextStyle(fontSize: 16.px, color: TKColor.color_999999), textAlign: TextAlign.center);
    itemList.add(SizedBox(height: 20.px));
    itemList.add(titleItem);

    Widget button = SmallButton(
      disabled: true,
      title: S.of(context).empty_refresh,
      onPressed: () {
        if (onPressed == null) { return; }
        onPressed();
      },
    );

    if (showReload) {
      itemList.add(SizedBox(height: 20.px));
      itemList.add(button);
    }

    return itemList;
  }
}


class ErrorView extends StatelessWidget {
  final String image;
  final String title;

  ErrorView({
    this.image = TKImages.empty_data, 
    this.title = '请求失败, 请稍后再试'
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(image, fit: BoxFit.contain, width: 130.px, height: 90.px),
          Text(title, style: TextStyle(fontSize: 16.px, color: TKColor.color_999999), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}