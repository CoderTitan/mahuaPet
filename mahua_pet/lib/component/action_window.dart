import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/styles/app_style.dart';


typedef ActionRowsSelect = void Function(int index, String title);


class TKActionPopWindow {
  static void showActionSheet(BuildContext context,{
    List<String> rows,
    bool showCancel = true,
    ActionRowsSelect selectAction,
  }) {
    
  } 
}

class TKActionWindow extends StatelessWidget {

  final List<String> rows;
  final bool showCancel;
  final ActionRowsSelect selectAction;

  TKActionWindow({
    Key key,
    @required List<String> rows,
    this.showCancel = true,
    this.selectAction,
  }): rows = rows ?? [], super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        
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

    return lists;
  }
}