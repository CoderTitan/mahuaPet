import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/find/view_model/view_model_index.dart';
import 'package:mahua_pet/providered/provider/consume_provider.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../models/model_index.dart';
import '../contents/find_video.dart';
import '../contents/find_detail.dart';

class FindRecomItem extends StatelessWidget {

  final RecommendModel recomModel;
  final FindActionCallBack actionCallBack;
  FindRecomItem({Key key, this.recomModel, this.actionCallBack}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConsumerProvider<FindRecomItemProvider>(
      model: FindRecomItemProvider(),
      builder: (_, itemVM, child) {
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
                renderHeaderImage(itemVM),
                renderOtherInfo(itemVM)
              ]
            ),
          ),
          onTap: () {
            jumpFindDetail(context, itemVM);
          },
        );
      },
    );
  }

  Widget renderOtherInfo(FindRecomItemProvider itemVM) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 8.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderChildren(itemVM)
      ),
    );
  }

  List<Widget> renderChildren(FindRecomItemProvider itemVM) {
    final model = itemVM.recomModel ?? recomModel;
    List<Widget> itemList = [];

    itemList.add(renderUserInfo(model));
    if (model.labelName != null && model.labelName.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderTopicItem(model));
    }
    
    if (model.messageInfo != null && model.messageInfo.length > 0) {
      itemList.add(SizedBox(height: 4.px));
      itemList.add(renderMessageItem(model));
    }

    itemList.add(SizedBox(height: 4.px));
    itemList.add(renderNumberItem(model));

    return itemList;
  }

  Widget renderHeaderImage(FindRecomItemProvider itemVM) {
    final model = itemVM.recomModel ?? recomModel;
    final imageWidth = (SizeFit.screenWidth - 25.px) / 2;

    return Stack(
      children: <Widget>[
        TKNetworkImage(
          imageUrl: model.videoCover ?? model.headImg,
          width: imageWidth,
          height: imageWidth / double.parse(model.coverWidth) * double.parse(model.coverHeight),
          boxRadius: 4.px,
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

  Widget renderUserInfo(RecommendModel model) {
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

  Widget renderTopicItem(RecommendModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
      decoration: BoxDecoration(
        color: TKColor.main_color[25],
        borderRadius: BorderRadius.circular(2.px),
      ),
      child: Text('#' + model.labelName, style: TextStyle(fontSize: 10.px, color: TKColor.main_color)),
    );
  }

  Widget renderMessageItem(RecommendModel model) {
    return Container(
      child: Text(model.messageInfo, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.px, color: TKColor.color_666666)),
    );
  }

  Widget renderNumberItem(RecommendModel model) {
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

  void jumpFindDetail(BuildContext context, FindRecomItemProvider itemVM) {
    final _model = itemVM.recomModel ?? recomModel;
    if (_model.messageType == '1') {
      TKRoute.push(context, FindVideoList(_model.messageId));
      return;
    }
    TKRoute.push(context, FindDetailPage(messageId: _model.messageId, actionCallBack: (model) {
      _model.agreeStatus = model.agreeStatus;
      _model.messageAgreeNum = '${model.cntAgree}';
      itemVM.recomModel = _model;
    }));
  }
}