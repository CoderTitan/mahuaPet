import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import '../models/model_index.dart';

class FindRecomItem extends StatelessWidget {

  final RecommendModel model;
  final FindActionCallBack actionCallBack;
  FindRecomItem({this.model, this.actionCallBack, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: (SizeFit.screenWidth - 25.px) / 2,
        decoration: BoxDecoration(
          color: TKColor.white,
          borderRadius: BorderRadius.circular(4.px),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            renderHeaderImage(),
            renderOtherInfo()
          ]
        ),
      ),
      onTap: () => actionCallBack(FindActionType.detail),
    );
  }

  Widget renderOtherInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 8.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderChildren()
      ),
    );
  }

  List<Widget> renderChildren() {
    List<Widget> itemList = [];

    itemList.add(renderUserInfo());
    if (model.labelName != null && model.labelName.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderTopicItem());
    }
    
    if (model.messageInfo != null && model.messageInfo.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderMessageItem());
    }

    itemList.add(SizedBox(height: 4.px));
    itemList.add(renderNumberItem());

    return itemList;
  }

  Widget renderHeaderImage() {
    final imageWidth = (SizeFit.screenWidth - 25.px) / 2;
    return Stack(
      children: <Widget>[
        TKNetworkImage(
          imageUrl: model.videoCover ?? model.headImg,
          width: imageWidth,
          height: imageWidth / double.parse(model.coverWidth) * double.parse(model.coverHeight),
          borderRadius: 4.px,
          fit: BoxFit.cover,
          showProgress: true,
          placeholder: TKImages.image_path + 'find_none_image.png',
        ),
        Positioned(
          child: Container(
            width: imageWidth,
            height: imageWidth / double.parse(model.coverWidth) * double.parse(model.coverHeight),
            child: model.messageType == '1' ? 
            Center(child: Image.asset(
              TKImages.image_path + 'find_play.png', 
              width: 40.px, height: 40.px,
              fit: BoxFit.fitWidth,
            )) : Container(),
          )
        )
      ],
    );
  }

  Widget renderUserInfo() {
    return Container(
      child: Row(
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: model.headImg,
            width: 20.px,
            height: 20.px,
            borderRadius: 10.px,
            fit: BoxFit.cover,
            placeholder: TKImages.user_header
          ),
          onTap: () => actionCallBack(FindActionType.header),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Text(model.nickname, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)),
        )
      ],
    ),
    );
  }

  Widget renderTopicItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
      decoration: BoxDecoration(
        color: TKColor.main_color[25],
        borderRadius: BorderRadius.circular(2.px),
      ),
      child: Text('#' + model.labelName, style: TextStyle(fontSize: 10.px, color: TKColor.main_color)),
    );
  }

  Widget renderMessageItem() {
    return Container(
      child: Text(model.messageInfo, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.px, color: TKColor.color_666666)),
    );
  }

  Widget renderNumberItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        renderBottomItem(
          model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
          model.agreeStatus == '1' ? TKColor.main_color: TKColor.color_cccccc,
          model.messageAgreeNum,
          FindActionType.agree
        ),
        renderBottomItem(
          Icons.remove_red_eye, TKColor.color_cccccc, 
          model.messageReadNum, FindActionType.none, textAlign: TextAlign.right
        ),
      ],
    );
  }

  Widget renderBottomItem(IconData icon, Color iconColor, String number, FindActionType type, {TextAlign textAlign = TextAlign.left}) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: iconColor, size: 14.px),
          SizedBox(width: 4.px),
          Text(number, style: TextStyle(fontSize: 12.px, color: TKColor.color_cccccc), textAlign: textAlign,
          )
        ],
      ),
      onTap: () => actionCallBack(type),
    );
  }
}