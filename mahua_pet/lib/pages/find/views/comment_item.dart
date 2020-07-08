import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import '../models/model_index.dart';
import 'comment_reply_item.dart';
import 'comment_info_item.dart';


class CommentItem extends StatelessWidget {
  final CommentModel model;
  CommentItem({this.model, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TKColor.white,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderItemList(),
      ),
    );
  }

  List<Widget> renderItemList() {
    List<Widget> itemList = [];

    Widget commentItem = CommentInfoItem(commentModel: model, isFirstComment: true, key: key);
    itemList.add(commentItem);
    if (model.commentReplyVOs != null && model.commentReplyVOs.length > 0) {
      itemList.add(CommentReplyItem(replyLists: model.commentReplyVOs, key: key));
    }

    return itemList;
  }
}