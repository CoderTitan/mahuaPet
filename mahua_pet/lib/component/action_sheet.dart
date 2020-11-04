import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'growth_alert.dart';


typedef ActionRowsSelect = void Function(int index, String title);


/// 从底部弹出
class TKActionSheet {
  /// 弹窗底部弹出通用方式
  static void bottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      builder: (ctx) => child
    );
  }


  static void showActionSheet(BuildContext context,{
    List<String> rows,
    bool showCancel = true,
    ActionRowsSelect selectAction,
  }) {
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.white,
      builder: (ctx) {
        return TKActionSheetWidget(
          rows: rows,
          showCancel: showCancel,
          selectAction: selectAction,
        );
    });
  } 


  
}

class TKActionSheetWidget extends StatelessWidget {

  final List<String> rows;
  final bool showCancel;
  final ActionRowsSelect selectAction;

  TKActionSheetWidget({
    Key key,
    @required List<String> rows,
    this.showCancel = true,
    this.selectAction,
  }): rows = rows ?? [], super(key: key);

  @override
  Widget build(BuildContext context) {
    final cellHeight = (rows.length + 1) * 55.px + 8;

    return Container(
        width: SizeFit.screenWidth,
        height: cellHeight + SizeFit.safeHeight,
        child: Column(
          children: renderItemList(context),
        ),
    );
  }
  
  List<Widget> renderItemList(BuildContext context) {
    List<Widget> lists = [];

    for (var i = 0; i < rows.length; i++) {
      Widget itemWidget = GestureDetector(
        child: Container(
          width: SizeFit.screenWidth,
          height: 55.px,
          child: Center(
            child: Text(rows[i], style: TextStyle(fontSize: 16.px, color: TKColor.color_1a1a1a)),
          ),
        ),
        onTap: () {
          selectAction(i, rows[i]);
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      );
      lists.add(itemWidget);
      if (i < rows.length - 1) {
        lists.add(Divider(
          height: 0.5, 
          indent: 16.px,
          endIndent: 16.px,
          color: TKColor.color_e5e5e5
        ));
      }
    }
    lists.add(Divider(thickness: 8, height: 8, color: TKColor.color_e5e5e5));

    Widget cancelWidget = GestureDetector(
      child: Container(
        width: SizeFit.screenWidth,
        height: 55.px,
        child: Center(
          child: Text('取消', style: TextStyle(fontSize: 16.px, color: TKColor.color_999999)),
        ),
      ),
      onTap: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
    lists.add(cancelWidget);

    return lists;
  }
}