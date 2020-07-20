import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';

class EmptyContent extends StatelessWidget {

  final String image;
  final String title;
  final bool showReload;
  final VoidCallback onPressed;

  EmptyContent({
    this.image = TKImages.empty_data,
    this.title = '当前没有数据哦',
    this.showReload = true,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.px, vertical: 32.px),
      child: Column(
        children: renderItems(),
      ),
    );
  }

  List<Widget> renderItems() {
    List<Widget> itemList = [];

    Widget imageItem = Image.asset(image, fit: BoxFit.contain, width: 258.px, height: 179.px);
    itemList.add(imageItem);

    Widget titleItem = Text(title, style: TextStyle(fontSize: 16.px, color: TKColor.color_999999), textAlign: TextAlign.center);
    itemList.add(SizedBox(height: 20.px));
    itemList.add(titleItem);

    Widget button = SmallButton(
      disabled: true,
      width: 80.px,
      height: 32.px,
      title: '点击刷新',
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