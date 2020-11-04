import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/grass_model.dart';


typedef HomeActionCallBack = void Function(GrassModel grassModel);

class HomeGridItem extends StatelessWidget {

  final GrassModel model;
  final HomeActionCallBack actionCallBack;
  HomeGridItem({Key key, this.model, this.actionCallBack}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return GestureDetector(
          child: Container(
            width: (SizeFit.screenWidth - 25.px) / 2,
            decoration: BoxDecoration(
              color: TKColor.whiteColor(store.state.isNightModal),
              borderRadius: BorderRadius.circular(4.px),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                renderHeaderImage(),
                renderOtherInfo(store.state)
              ]
            ),
          ),
          onTap: () {
            actionCallBack(model);
          },
        );
      },
    );
  }

  Widget renderOtherInfo(TKState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 8.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderChildren(state)
      ),
    );
  }

  List<Widget> renderChildren(TKState state) {
    List<Widget> itemList = [];

    itemList.add(renderUserInfo(state));
    if (model.labelName != null && model.labelName.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderTopicItem(state));
    }
    
    if (model.messageInfo != null && model.messageInfo.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderMessageItem(state));
    }

    itemList.add(SizedBox(height: 4.px));
    itemList.add(renderNumberItem(state));

    return itemList;
  }

  Widget renderHeaderImage() {
    final imageWidth = (SizeFit.screenWidth - 25.px) / 2;

    return TKNetworkImage(
      imageUrl: model.fileUrl ?? '',
      width: imageWidth,
      height: imageWidth,
      boxRadius: 4.px,
      fit: BoxFit.cover,
      showProgress: true,
      placeholder: TKImages.image_empty,
    );
  }

  Widget renderUserInfo(TKState state) {
    return Container(
      child: Row(
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: model.headImg,
            width: 20.px,
            height: 20.px,
            boxRadius: 10.px,
            fit: BoxFit.cover,
            placeholder: TKImages.user_header
          ),
          onTap: () => actionCallBack(model),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Text(
            model.nickname, maxLines: 1, 
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 14.px, color: TKColor.blackColor(state.isNightModal))
          ),
        )
      ],
    ),
    );
  }

  Widget renderTopicItem(TKState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
      decoration: BoxDecoration(
        color: TKColor.marginColor(state.isNightModal),
        borderRadius: BorderRadius.circular(2.px),
      ),
      child: Text(
        '#' + model.labelName, 
        style: TextStyle(
          fontSize: 10.px, 
          color: state.isNightModal? TKColor.color_edf2fa : state.themeData.primaryColor
        )
      ),
    );
  }

  Widget renderMessageItem(TKState state) {
    final mainColor = state.isNightModal ? TKColor.white : state.themeData.primaryColor;
    return Container(
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.px),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor, width: 0.5),
                borderRadius: BorderRadius.circular(2)
              ),
              child: Text('种草', style: TextStyle(fontSize: 9.px, color: mainColor)),
            )),
            TextSpan(
              text: ' ' + model.messageInfo,
              style: TextStyle(fontSize: 12.px, color: TKColor.grayColor(state.isNightModal))
            )
          ]
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis, 
      ),
    );
  }

  Widget renderNumberItem(TKState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        renderBottomItem(
          model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
          model.agreeStatus == '1' ? (state.isNightModal? TKColor.color_edf2fa : state.themeData.primaryColor) : TKColor.lightGray(state.isNightModal),
          model.messageAgreenum,
          state,
        ),
        renderBottomItem(
          Icons.remove_red_eye, 
          TKColor.lightGray(state.isNightModal), 
          model.messageCommentnum, 
          state, 
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget renderBottomItem(IconData icon, Color iconColor, String number, TKState state, {TextAlign textAlign = TextAlign.left}) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: iconColor, size: 14.px),
          SizedBox(width: 4.px),
          Text(number ?? '', style: TextStyle(fontSize: 12.px, color: TKColor.lightGray(state.isNightModal)), textAlign: textAlign,
          )
        ],
      ),
      onTap: () => actionCallBack(model),
    );
  }
      
}