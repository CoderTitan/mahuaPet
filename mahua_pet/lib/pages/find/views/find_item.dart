import 'package:flutter/material.dart';
import 'package:mahua_pet/component/network_image.dart';
import 'package:mahua_pet/pages/find/contents/photo_preview.dart';
import 'package:mahua_pet/pages/find/models/focus_post_model.dart';
import 'package:mahua_pet/pages/find/models/model_index.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/utils/route_util.dart';


import './find_item_image.dart';

class FindListItem extends StatelessWidget {

  final FocusPostModel _model;

  final FocusPostModel model;
  final FindActionCallBack findCallBack;
  

  FindListItem({this.model, this.findCallBack, Key key}): _model = model, super(key: key);

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
      onTap: () {
        findCallBack(FindActionType.detail);
      },
    );
  }

  List<Widget> getItemList(BuildContext context) {
    List<Widget> itemList = [];
    itemList.add(userInfoItem(context));

    if (_model.messageInfo != null && _model.messageInfo.isNotEmpty) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderTextItem(context));
    }

    if (_model.fileCount > 0) {
      itemList.add(renderMediaItems(context));
    }

    if (_model.userInfo.city != null && _model.userInfo.city.isNotEmpty) {
      itemList.add(renderLocationItem());
    }

    if (_model.commentList.length > 0) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderCommonList());
    }

    itemList.add(SizedBox(height: 8.px));
    itemList.add(Divider(color: TKColor.color_e8e8e8, height: 0.5));
    itemList.add(renderBottomItem(context));
    return itemList;
  }

  Widget userInfoItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: renderHeaderItems(),
    );
  }

  List<Widget> renderHeaderItems() {
    List<Widget> itemList = [];

    Widget user = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: _model.userInfo.headImg,
            width: 45.px, height: 45.px,
            borderRadius: 30.px,
            fit: BoxFit.cover,
          ),
          onTap: () => findCallBack(FindActionType.header),
        ),
        SizedBox(width: 8.px),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_model.userInfo.nickname, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)),
            Text(_model.createTime, style: TextStyle(fontSize: 11.px, color: TKColor.color_999999)),
          ],
        )
      ],
    );
    itemList.add(user);

    LoginInfo loginInfo = SharedStorage.loginInfo;
    if (loginInfo.userId != _model.userId) {
      Widget button = FocusButton(
        isSelect: model.followStatus == '关注',
        onPressed: () => findCallBack(FindActionType.attation)
      );
      itemList.add(button);
    }

    return itemList;
  }

  Widget renderTextItem(BuildContext context) {
    return Text(
      _model.messageInfo ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14.px, color: TKColor.color_333333),
    );
  }

  Widget renderMediaItems(BuildContext context) {
    final media = _model.fileList.first;
    if (media.fileType == '0') {
      return renderImages(context);
    }
    return Container();
  }

  Widget renderImages(BuildContext context) {
    final imgArray = _model.fileList;
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
            List<String> images = [imgModel.fileUrl];
            TKRoute.pushImagePreview(context, PhotoPreview(index: 0, images: [imgModel.fileUrl]));
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
          final itemIndex = imgArray.indexOf(item) ?? 0;
          return FindItemImage(
            key: ValueKey(itemIndex),
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
          Text(_model.userInfo.city, style: TextStyle(fontSize: 13.px, color: TKColor.color_6f6f6f))
        ],
      ),
    );
  }

  Widget renderCommonList() {
    return Container(
      padding: EdgeInsets.all(8.px),
      width: SizeFit.screenWidth - 32.px,
      decoration: BoxDecoration(
        color: TKColor.color_f7f7f7,
        borderRadius: BorderRadius.circular(4.px)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderCommonChildren(_model.commentList)
      ),
    );
  }

  List<Widget> renderCommonChildren(List<CommentList> commonList) {
    List<CommentList> newList = commonList.length > 3 ? commonList.sublist(0, 3) : commonList;
    List<Widget> commonWidgets = [];
    for (var i = 0; i < newList.length; i++) {
      CommentList item = newList[i];
      Widget span = Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Text(item.nickname + ': ', style: TextStyle(fontSize: 13.px, color: TKColor.color_526e94)),
              alignment: PlaceholderAlignment.middle
            ),
            ...item.commentInfo.runes.map((rune) {
              return WidgetSpan(
                child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 13.px, color: TKColor.color_666666)),
                alignment: PlaceholderAlignment.middle
              );
            }).toList()
          ]
        ),
        softWrap: true,
      );
      commonWidgets.add(span);
      if (i < newList.length - 1) {
        commonWidgets.add(SizedBox(height: 3.px));
      }
    }

    if (commonList.length > 3) {
      commonWidgets.add(SizedBox(height: 5.px));
      Widget spanIcon = Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Text('查看更多评论', style: TextStyle(fontSize: 13.px, color: TKColor.color_526e94)),
              alignment: PlaceholderAlignment.middle
            ),
            WidgetSpan(
              child: Icon(Icons.keyboard_arrow_right, size: 20.px, color: TKColor.color_526e94),
              alignment: PlaceholderAlignment.middle
            )
          ]
        ),
      );
      commonWidgets.add(spanIcon);
    }

    return commonWidgets;
  }

  Widget renderBottomItem(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.px),
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
      _model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
      _model.agreeStatus == '1' ? TKColor.main_color : TKColor.color_666666,
      '${_model.cntAgree}',
      FindActionType.agree
    ));
    itemList.add(bottomItem(Icons.message, TKColor.color_666666, '${_model.cntComment}', FindActionType.comment));
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
            Text(number, style: TextStyle(fontSize: 13.px, color: TKColor.color_666666))
          ],
        ),
      ),
      onTap: () {
        findCallBack(type);
      },
    );
  }
}


