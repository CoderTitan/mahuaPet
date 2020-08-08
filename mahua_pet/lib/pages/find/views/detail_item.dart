import 'package:flutter/material.dart';
import 'package:mahua_pet/component/network_image.dart';
import '../models/model_index.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import './find_item_image.dart';
import '../contents/photo_preview.dart';





class FindDetailItem extends StatelessWidget {

  final DetailModel model;
  final FindActionCallBack eventAction;
  FindDetailItem(this.model, this.eventAction);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getItemList(context)
            ),
          ),
          Container(height: 10.px, color: TKColor.color_f7f7f7)
        ],
      ),
    );
  }

  List<Widget> getItemList(BuildContext context) {
    List<Widget> itemList = [];
    itemList.add(userInfoItem(context));

    if (model.labelName != null && model.labelName.isNotEmpty) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderTopicItem());
    }

    if (model.messageInfo != null && model.messageInfo.isNotEmpty) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderTextItem(context));
    }

    if (model.files != null && model.files.length > 0) {
      itemList.add(renderMediaItems(context));
    }

    if (model.city != null && model.city.isNotEmpty) {
      itemList.add(renderLocationItem());
    }

    itemList.add(SizedBox(height: 8.px));
    itemList.add(Divider(color: TKColor.color_e8e8e8, height: 0.5));
    itemList.add(renderBottomItem(context));
    return itemList;
  }

  Widget userInfoItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: TKNetworkImage(
                imageUrl: model.headImg ?? '',
                width: 45.px, height: 45.px,
                boxRadius: 30.px,
                fit: BoxFit.cover,
                placeholder: TKImages.user_header,
              ),
              onTap: () { eventAction(FindActionType.header); },
            ),
            SizedBox(width: 8.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.nickName ?? '', style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)),
                Text(model.createTime ?? '', style: TextStyle(fontSize: 11.px, color: TKColor.color_999999)),
              ],
            )
          ],
        ),
        FocusButton(
          isSelect: model.followStatus == '关注',
          onPressed: () => eventAction(FindActionType.attation)
        )
      ],
    );
  }

  Widget renderTopicItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
      decoration: BoxDecoration(
        color: TKColor.main_color[25],
        borderRadius: BorderRadius.circular(2.px),
      ),
      child: Text('#' + model.labelName ?? '', style: TextStyle(fontSize: 10.px, color: TKColor.main_color)),
    );
  }

  Widget renderTextItem(BuildContext context) {
    return Text(
      model.messageInfo ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14.px, color: TKColor.color_333333),
    );
  }

  Widget renderMediaItems(BuildContext context) {
    final media = model.files.first;
    if (media.fileType == '0') {
      return renderImages(context);
    }
    return Container();
  }

  Widget renderImages(BuildContext context) {
    final imgArray = model.files;
    if (imgArray.length == 1) {
      final imgModel = imgArray.first;
      return Container(
        padding: EdgeInsets.only(top: 8.px),
        child: FindItemImage(
          imageUrl: imgModel.fileUrl,
          width: 140.px,
          height: 180.px,
          radius: 10.px,
          onPress: () {
            List<String> images = imgArray.map((e) => e.fileUrl).toList();
            TKRoute.pushImagePreview(context, PhotoPreview(index: 0, images: images));
          },
        ),
      );
    } 
    final imageWidth = imgArray.length == 4 ? 120.px : 107.px;
    return Container(
      padding: EdgeInsets.only(top: 8.px),
      child: Wrap(
        spacing: 10.px,
        runSpacing: 10.px,
        children: imgArray.map((item) {
          final itemIndex = imgArray.indexOf(item);
          return FindItemImage(
            imageUrl: item.fileUrl,
            width: imageWidth,
            height: imageWidth,
            radius: 4.px,
            onPress: () {
              List<String> images = imgArray.map((e) => e.fileUrl).toList();
              TKRoute.pushImagePreview(context, PhotoPreview(index: itemIndex, images: images));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget renderLocationItem() {
    return Container(
      padding: EdgeInsets.only(top: 8.px),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on, size: 16.px, color: TKColor.color_666666),
          SizedBox(width: 4.px),
          Text(model.city, style: TextStyle(fontSize: 13.px, color: TKColor.color_6f6f6f))
        ],
      ),
    );
  }

  Widget renderBottomItem(BuildContext context) {
    return Container(
      height: 40.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getBottomItem(),
      ),
    );
  }

  List<Widget> getBottomItem() {

    List<Widget> itemList = [];

    itemList.add(bottomItem(
      model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border, 
      model.agreeStatus == '1' ? TKColor.main_color : TKColor.color_666666, 
      '${model.cntAgree}',
      FindActionType.agree
    ));
    itemList.add(bottomItem(
      model.collectionsStatus == '1' ? Icons.star : Icons.star_border, 
      model.collectionsStatus == '1' ? TKColor.main_color : TKColor.color_666666, 
      model.collectionNum, 
      FindActionType.collection
    ));
    itemList.add(bottomItem(Icons.message, TKColor.color_666666, model.commentNum, FindActionType.comment));
    itemList.add(bottomItem(Icons.share, TKColor.color_666666, '', FindActionType.share));

    return itemList;
  }

  Widget bottomItem(IconData icon, Color iconColor, String number, FindActionType type) {
    return GestureDetector(
      child: Container(
        width: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 20.px, color: iconColor,),
            SizedBox(width: 3.px),
            Text('$number', style: TextStyle(fontSize: 13.px, color: TKColor.color_666666))
          ],
        ),
      ),
      onTap: () {
        eventAction(type);
      },
    );
  }
}