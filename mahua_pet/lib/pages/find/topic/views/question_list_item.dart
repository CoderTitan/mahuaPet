
import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/question_list_model.dart';

class QuestionListItem extends StatelessWidget {

  final QuestionListModel model;

  QuestionListItem({
    Key key,
    this.model
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border(top: BorderSide(color: TKColor.color_f7f7f7))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          renderUserInfo(),
          SizedBox(height: 6.px),
          renderContent(),
        ],
      ),
    );
  }

  Widget renderUserInfo() {
    Widget item = Row(
      children: <Widget>[
        TKNetworkImage(
          imageUrl: model.headImg ?? '',
          placeholder: TKImages.user_header,
          width: 40.px, height: 40.px,
          boxRadius: 20.px,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 8.px),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.nickname ?? '', style: TextStyle(fontSize: 16.px, color: TKColor.color_333333)),
            SizedBox(height: 4.px),
            Text(model.createTime ?? '', style: TextStyle(fontSize: 12.px, color: TKColor.color_999999))
          ],
        )
      ],
    );
    return item;
  }

  Widget renderContent() {
    Widget item = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            model.textDescription ?? '', 
            maxLines: 3, 
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 14.px, color: TKColor.color_999999)
          ),
        ),
        SizedBox(width: 10.px),
        model.firstFile != null && model.firstFile.length > 0 ?
        TKNetworkImage(
          imageUrl: model.firstFile,
          placeholder: TKImages.image_empty,
          width: 95.px, height: 70.px,
          boxRadius: 5.px,
          fit: BoxFit.cover,
        ) : Container(),
      ],
    );
    return item;
  }
}