import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../models/model_index.dart';


class CommentReplyItem extends StatefulWidget {
  final List<CommentReplyVo> replyLists;
  CommentReplyItem({this.replyLists, Key key}): super(key: key);

  @override
  _CommentReplyItemState createState() => _CommentReplyItemState();
}

class _CommentReplyItemState extends State<CommentReplyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.px, top: 10.px),
      child: Column(
        
      ),
    );
  }
}