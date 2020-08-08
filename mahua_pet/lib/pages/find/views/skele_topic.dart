import 'package:flutter/material.dart';
import 'package:mahua_pet/component/skeleton_list.dart';
import 'package:mahua_pet/styles/app_style.dart';

class SkeleTopicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: TKColor.color_f7f7f7))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SkeletonContainer(width: SizeFit.screenWidth - 80.px, height: 20.px),
          SizedBox(height: 4.px),
          Row(
            children: <Widget>[
              SkeletonContainer(width: 16.px, height: 16.px, isCircle: true),
              SizedBox(width: 4.px),
              SkeletonContainer(width: 100.px, height: 14.px),
              SizedBox(width: 4.px),
              SkeletonContainer(width: 40.px, height: 14.px),
            ],
          ),
          SizedBox(height: 6.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SkeletonContainer(width: SizeFit.screenWidth - 160.px, height: 15.px),
                  SizedBox(height: 4.px),
                  SkeletonContainer(width: SizeFit.screenWidth - 160.px, height: 15.px),
                  SizedBox(height: 4.px),
                  SkeletonContainer(width: SizeFit.screenWidth - 280.px, height: 15.px),
                ],
              ),
              SizedBox(width: 16.px),
              SkeletonContainer(width: 95.px, height: 70.px),
            ],
          ),
          SizedBox(height: 6.px),
          Row(
            children: <Widget>[
              SkeletonContainer(width: 16.px, height: 16.px),
              SizedBox(width: 30.px),
              SkeletonContainer(width: 16.px, height: 16.px),
            ],
          ),
        ],
      ),
    );
  }
}