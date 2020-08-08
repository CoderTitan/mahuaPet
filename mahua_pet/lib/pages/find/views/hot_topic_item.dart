
import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/models/hot_topic.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';


class HotTopicItem extends StatelessWidget {

  final HotTopicModel model;
  
  HotTopicItem({
    Key key,
    this.model
  }): super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.px,
      height: 166.px,
      margin: EdgeInsets.only(right: 12.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border.all(color: TKColor.color_e8e8e8, width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              TKNetworkImage(
                imageUrl: model.headImg,
                width: 100.px,
                height: 100.px,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                fit: BoxFit.cover,
                placeholder: TKImages.image_empty,
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  color: Colors.black12,
                  height: 22.px,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person, color: TKColor.white, size: 16.px),
                      Text('${model.tribeUserCount}人', style: TextStyle(fontSize: 14.px, color: TKColor.white))
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8.px),
          Text(model.tribeName, style: TextStyle(fontSize: 16.px, color: TKColor.color_1a1a1a)),
          SizedBox(height: 8.px),
          FocusButton(
            isSelect: model.isCollect == '',
            onPressed: () {}
          )
        ],
      ),
    );
  }
}