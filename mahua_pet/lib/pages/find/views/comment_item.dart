import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'comment_reply_item.dart';


class CommentItem extends StatelessWidget {
  final CommentModel model;
  final int userId;
  final FindActionCallBack actionCallBack;
  CommentItem({this.model, this.userId, this.actionCallBack, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border(bottom: BorderSide(color: TKColor.color_f7f7f7))
      ),
      padding: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderFirstCommentItem(),
      ),
    );
  }

  List<Widget> renderFirstCommentItem() {
    List<Widget> itemList = [];

    itemList.add(renderUserInfo());
    itemList.add(renderCommentInfo());

    if (model.commentReplyVOs != null && model.commentReplyVOs.length > 0) {
      itemList.add(CommentReplyItem(replyLists: model.commentReplyVOs, userId: userId, key: key));
    }

    return itemList;
  }

  Widget renderUserInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          renderUserLeft(),
          renderUserRight()
        ],
      ),
    );
  }

  Widget renderCommentInfo() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 36.px, right: 20.px, top: 3.px),
        child: Text(
          model.commentInfo, 
          style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)
        ),
      ),
      onTap: () {
        actionCallBack(FindActionType.commentSelect);
      },
    );
  }

  Widget renderUserLeft() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: model.headImg ?? '',
            width: 30.px, height: 30.px,
            boxRadius: 20.px,
            fit: BoxFit.cover,
            placeholder: TKImages.user_header,
          ),
          onTap: () {
            // 直接进去就好
            
          },
        ),
        SizedBox(width: 6.px),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: renderTitleItem()),
            Text(
              model.publishTime, 
              style: TextStyle(fontSize: 10.px, color: TKColor.color_999999)
            )
          ],
        )
      ],
    );
  }

  Widget renderUserRight() {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Icon(
            model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border, 
            color: model.agreeStatus == '1' ? TKColor.main_color : TKColor.color_999999,
            size: 20.px, 
          ),
          Text(
            '${model.cntAgree}', 
            style: TextStyle(fontSize: 10.px, color: TKColor.color_666666)
          )
        ],
      ),
      onTap: () {
        actionCallBack(FindActionType.agree);
      },
    );
  }

  List<Widget> renderTitleItem() {
    List<Widget> itemList = [];

    Widget title = Text(
      model.nickname,
      style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
    );
    itemList.add(title);
    itemList.add(SizedBox(width: 4.px));

    if (userId == model.userId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4.px),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.px), color: TKColor.color_79b7f7),
        child: Text('作者', style: TextStyle(fontSize: 9.px, color: TKColor.white)),
      );
      itemList.add(logo);
    }

    return itemList;
  }


}