import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'calendar_record_share.dart';

class CalendarCardItem extends StatelessWidget {

  final List<RecordListModel> cardModels;
  CalendarCardItem({this.cardModels});

  @override
  Widget build(BuildContext context) {
    if (cardModels.length == 0) {
      return Container();
    }
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
        child: Column(
          children: [
            renderTitle(context),
            renderCardList()
          ],
        ),
      ),
    );
  }

  Widget renderTitle(BuildContext context) {
    return Container(
      height: 44.px,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: TKColor.color_eeeeee, width: 0.5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('日常打卡', style: TextStyle(fontSize: 16.px, color: TKColor.color_333333, fontWeight: FontWeight.bold)),
          IconButton(
            icon: Icon(Icons.share, color: TKColor.color_666666), 
            iconSize: 18.px,
            onPressed: () {
              TKActionAlert.showCenter(
                context, 
                barrierDismissible: true,
                child: CardRecordShareItem(models: cardModels)
              );
            }
          )
        ],
      ),
    );
  }

  Widget renderCardList() {
    return Column(
      children: cardModels.map((e) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 8.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(TKImages.asset('record_icon'), width: 24, height: 24),
              Text(e.name, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333))
            ],
          ),
        );
      }).toList(),
    );
  }
}