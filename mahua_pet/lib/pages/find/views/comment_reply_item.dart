import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';


class CommentReplyItem extends StatefulWidget {
  final List<CommentReplyVo> replyLists;
  final int userId;
  CommentReplyItem({this.replyLists, this.userId, Key key}): super(key: key);

  @override
  _CommentReplyItemState createState() => _CommentReplyItemState();
}

class _CommentReplyItemState extends State<CommentReplyItem> {

  bool _showAll = false;
  int _maxCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.px, top: 10.px),
      child: Column(
        children: renderAllComment(),
      ),
    );
  }

  List<Widget> renderAllComment() {
    final commentCount = widget.replyLists.length;
    
    int showCount = commentCount;
    if (commentCount > _maxCount) {
      showCount = _showAll ? commentCount : _maxCount;
    }

    List<Widget> commentList = [];
    for (var i = 0; i < showCount; i++) {
      commentList.add(renderCommentItem(widget.replyLists[i]));
    }

    if (commentCount > _maxCount) {
      commentList.add(renderShowAllButton());
    }

    return commentList;
  }

  Widget renderCommentItem(CommentReplyVo model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: renderUserInfoItems(model)),
          renderCommentInfo(model)
        ],
      ),
    );
  }

  List<Widget> renderUserInfoItems(CommentReplyVo model) {
    List<Widget> commentList = [];

    Widget headerImage = GestureDetector(
      child: TKNetworkImage(
        imageUrl: model.headImg ?? '',
        width: 18.px, height: 18.px,
        boxRadius: 10.px,
        fit: BoxFit.cover,
        placeholder: TKImages.user_header,
      ),
      onTap: () {},
    );
    commentList.add(headerImage);

    Widget title = Text(model.replyNickname, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666));
    commentList.add(SizedBox(width: 4.px));
    commentList.add(title);

    Widget time = Text(model.replyPublishTime, style: TextStyle(fontSize: 11.px, color: TKColor.color_999999));
    commentList.add(SizedBox(width: 4.px));
    commentList.add(time);

    if (widget.userId == model.replyUserId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4.px),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.px), color: TKColor.color_79b7f7),
        child: Text('作者', style: TextStyle(fontSize: 9.px, color: TKColor.white)),
      );
      commentList.add(SizedBox(width: 4.px));
      commentList.add(logo);
    }

    return commentList;
  }

  Widget renderCommentInfo(CommentReplyVo model) {
    String nickName = model.nickname + ': ';
    return Container(
      padding: EdgeInsets.only(left: 24.px, right: 20.px, top: 3.px),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text('回复', style: TextStyle(fontSize: 13.px, color: TKColor.color_666666)),
              alignment: PlaceholderAlignment.middle
            ),
            ...nickName.runes.map((rune) {
              return WidgetSpan(
                child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 14.px, color: TKColor.color_526e94)),
                alignment: PlaceholderAlignment.middle
              );
            }).toList(),
            ...model.commentInfo.runes.map((rune) {
              return WidgetSpan(
                child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 13.px, color: TKColor.color_333333)),
                alignment: PlaceholderAlignment.middle
              );
            }).toList(),
          ]
        )
      )
    );
  }

  Widget renderShowAllButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.px),
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Text(_showAll ? '收起': '展开所有', style: TextStyle(fontSize: 13.px, color: TKColor.color_526e94)),
                alignment: PlaceholderAlignment.middle
              ),
              WidgetSpan(
                child: Icon(Icons.arrow_drop_down, size: 14.px, color: TKColor.color_526e94),
                alignment: PlaceholderAlignment.middle
              ),
            ]
          )
        ),
      ),
      onTap: () {
        setState(() {
          _showAll = !_showAll;
        });
      },
    );
  }
}