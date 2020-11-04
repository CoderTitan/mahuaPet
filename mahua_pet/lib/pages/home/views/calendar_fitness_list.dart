import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/contents/photo_preview.dart';
import 'package:mahua_pet/pages/find/views/find_item_image.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../models/model_index.dart';

class CalendarFitItem extends StatelessWidget {

  final CalendarFitModel model;

  CalendarFitItem({this.model, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.px),
      child: Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renderTitle(),
            SizedBox(height: 10.px),
            Text('医院：' + model.symptom, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
            SizedBox(height: 6.px),
            Text('诊断结果：' + model.diagnosticResult, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
            SizedBox(height: 6.px),
            Text('病情描述：' + model.desc, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
            renderImageList(context),
            SizedBox(height: 4.px),
          ],
        ),
      ),
    ),
    );
  }

  Widget renderTitle() {
    final titles = model.createTime.split(' ').toList();
    return Container(
      height: 44.px,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: TKColor.color_eeeeee, width: 0.5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('健康管理', style: TextStyle(fontSize: 16.px, color: TKColor.color_333333, fontWeight: FontWeight.bold)),
          Text(titles.last, style: TextStyle(fontSize: 12.px, color: TKColor.color_999999)),
        ],
      ),
    );
  }

  Widget renderImageList(BuildContext context) {
    if (model.diseaseFiles == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 8.px),
      child: Wrap(
        spacing: 10.px,
        runSpacing: 10.px,
        children: model.diseaseFiles.map((e) {
          final index = model.diseaseFiles.indexOf(e) ?? 0;
          return FindItemImage(
            imageUrl: e.fileUrl,
            width: 90.px,
            height: 90.px,
            radius: 4.px,
            onPress: () {
              TKRoute.pushImagePreview(context, PhotoPreview(index: index, images: model.diseaseFiles.map((e) => e.fileUrl).toList()));
            },
          );
        }).toList(),
      ),
    );
  }
}