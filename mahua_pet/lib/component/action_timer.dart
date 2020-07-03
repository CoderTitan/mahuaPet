
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';


class TKDatePickerAction {
  static void showActionSheet(BuildContext context,{
    CupertinoDatePickerMode mode,
    DateTime initialDateTime,
    DateTime minimumDate,
    DateTime maximumDate,
    bool use24hFormat = true,
    @required ValueChanged<DateTime> onDateTimeChanged,
  }) {
    CupertinoDatePickerMode dateMode = mode ?? CupertinoDatePickerMode.date;
    showCupertinoModalPopup(
      context: context, 
      builder: (ctx) {
        return TKActionDateWidget(
          mode: dateMode,
          initialDateTime: initialDateTime,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          use24hFormat: use24hFormat,
          onDateTimeChanged: onDateTimeChanged,
        );
      }
    );
  } 
}

class TKActionDateWidget extends StatelessWidget {

  final CupertinoDatePickerMode mode;
  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool use24hFormat;
  final ValueChanged<DateTime> onDateTimeChanged;

  TKActionDateWidget({
    Key key,
    this.mode = CupertinoDatePickerMode.date,
    @required this.onDateTimeChanged,
    DateTime initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.use24hFormat = true,
  }): initialDateTime = initialDateTime ?? DateTime.now(), 
  super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        width: SizeFit.screenWidth,
        height: 300.px,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            renderHeaderItem(context),
            renderDatePicker(context)
          ],
        ),
    );
  }

  Widget renderHeaderItem(BuildContext context) {
    return Container(
      height: 50.px,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Text('取消', style: TextStyle(fontSize: 16.px, color: TKColor.color_6f6f6f)),
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
            GestureDetector(
              child: Text('确定', style: TextStyle(fontSize: 16.px, color: TKColor.color_6f6f6f)),
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
  
  Widget renderDatePicker(BuildContext context) {
    return SizedBox(
      height: 200.px,
      child: CupertinoDatePicker(
        mode: mode,
        initialDateTime: initialDateTime,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        use24hFormat: use24hFormat,
        onDateTimeChanged: (date) {
          onDateTimeChanged(date);
        }
      ),
    );
  }
}