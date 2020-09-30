import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import '../models/model_index.dart';

class CommentInfoItem extends StatefulWidget {

  final CommentModel commentModel;
  final CommentReplyVo replyModel;
  final bool isFirstComment;
  CommentInfoItem({this.commentModel, this.replyModel, this.isFirstComment, Key key}): super(key: key);

  @override
  _CommentInfoItemState createState() => _CommentInfoItemState();
}

class _CommentInfoItemState extends State<CommentInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: renderItemList(),
    );
  }

  List<Widget> renderItemList() {
    List<Widget> itemList = [];

    itemList.add(renderUserInfo());
    itemList.add(renderCommentInfo());

    return itemList;
  }

  Widget renderCommentInfo() {
    CommentModel comment = widget.commentModel;
    CommentReplyVo reply = widget.replyModel;
    bool isComment = widget.isFirstComment;
    return Container(
      padding: EdgeInsets.only(left: 36.px, right: 20.px, top: 3.px),
      child: Text(
        isComment ? comment.commentInfo : reply.commentInfo, 
        style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)
      ),
    );
  }

  Widget renderUserInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: renderUserItem(),
      ),
    );
  }

  List<Widget> renderUserItem() {
    bool isComment = widget.isFirstComment;
    List<Widget> itemList = [];

    itemList.add(renderUserLeft());
    if (isComment) {
      itemList.add(renderUserRight());
    }

    return itemList;
  }

  Widget renderUserLeft() {
    CommentModel comment = widget.commentModel;
    CommentReplyVo reply = widget.replyModel;
    bool isComment = widget.isFirstComment;
    return Row(
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: (isComment ? comment.headImg : reply.headImg) ?? '',
            width: 30.px, height: 30.px,
            boxRadius: 20.px,
            fit: BoxFit.cover,
            placeholder: TKImages.user_header,
          ),
          onTap: () {},
        ),
        SizedBox(width: 6.px),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: renderTitleItem()),
            Text(
              isComment ? comment.publishTime : reply.replyPublishTime, 
              style: TextStyle(fontSize: 10.px, color: TKColor.color_999999)
            )
          ],
        )
      ],
    );
  }

  Widget renderUserRight() {
    CommentModel comment = widget.commentModel;
    return Column(
      children: <Widget>[
        Icon(Icons.favorite_border, size: 20.px, color: TKColor.color_999999),
        Text(
          '${comment.cntAgree}', 
          style: TextStyle(fontSize: 10.px, color: TKColor.color_666666)
        )
      ],
    );
  }

  List<Widget> renderTitleItem() {
    CommentModel comment = widget.commentModel;
    CommentReplyVo reply = widget.replyModel;
    bool isComment = widget.isFirstComment;
    LoginInfo loginInfo = SharedStorage.loginInfo;
    List<Widget> itemList = [];

    Widget title = Text(
      isComment ? comment.nickname : reply.replyNickname,
      style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
    );
    itemList.add(title);
    itemList.add(SizedBox(width: 4.px));

    final userId = isComment ? comment.userId : reply.replyUserId;
    if (loginInfo.userId == userId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.px), color: TKColor.color_79b7f7),
        child: Text('作者', style: TextStyle(fontSize: 9.px, color: TKColor.white)),
      );
      itemList.add(logo);
    }

    return itemList;
  }
}