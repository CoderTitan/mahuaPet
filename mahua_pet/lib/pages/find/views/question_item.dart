
import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/models/hot_question.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../view_model/topic_state_provider.dart';

class QuestionItem extends StatelessWidget {

  final QuestionModel model;

  QuestionItem({
    Key key,
    this.model
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.px),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: TKColor.color_e8e8e8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          renderTItle(),
          renderUserInfo(),
          SizedBox(height: 6.px),
          renderContent(),
          SizedBox(height: 6.px),
          renderBottom()
        ],
      ),
    );
  }

  Widget renderTItle() {
    return Text(model.title ?? '', style: TextStyle(fontSize: 20.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.w500));
  }

  Widget renderUserInfo() {
    Widget item = Row(
      children: <Widget>[
        TKNetworkImage(
          imageUrl: model.headImg ?? '',
          placeholder: TKImages.user_header,
          width: 16.px, height: 16.px,
          boxRadius: 10.px,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 4.px),
        Text(model.nickname ?? '', style: TextStyle(fontSize: 14.px, color: TKColor.color_999999)),
        SizedBox(width: 4.px),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 1.px),
          decoration: BoxDecoration(
            color: TKColor.color_ffea9e_33,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: TKColor.main_color)
          ),
          child: Text(model.tribeName ?? '', style: TextStyle(fontSize: 8.px, color: TKColor.main_color)),
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
            model.firstAnswer ?? '', 
            maxLines: 3, 
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 16.px, color: TKColor.color_666666, height: 1.5)
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

  Widget renderBottom() {
    Widget item = Row(
      children: <Widget>[
        renderAgreeItem(),
        SizedBox(width: 30.px),
        renderBottomItem(Icons.message, TKColor.color_cccccc, '${model.commentNum}'),
      ],
    );

    return item;
  }

  Widget renderAgreeItem() {
    return ConsumerProvider<TopicStateProvider>(
      model: TopicStateProvider(),
      builder: (ctx, agreeVM, child) {
        final currentModel = agreeVM.currentModel ?? model;
        final isAgree = currentModel.agreeStatus == '1';
        return GestureDetector(
          child: renderBottomItem(
            isAgree ? Icons.favorite : Icons.favorite_border, 
            isAgree ? TKColor.main_color : TKColor.color_cccccc, 
            isAgree ? '${currentModel.agreeNum}' : '${model.agreeNum}'
          ),
          onTap: () {
            agreeVM.agreeAction(model);
          },
        );
      }, 
    );
  }

  Widget renderBottomItem(IconData icon, Color color, String number) {
    return Row(
      children: <Widget>[
        Icon(icon, color: color, size: 18.px),
        SizedBox(width: 4.px),
        Text('${number == 'null' ? '0' : number}', style: TextStyle(fontSize: 14.px, color: TKColor.color_666666))
      ],
    );
  }
}