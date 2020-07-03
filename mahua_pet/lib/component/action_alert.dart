
import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';

class ActionAlert {
  
  // 中间显示的取消/确认弹窗
  static showActionAlert(BuildContext context, {
    String title,
    String contentStr,
    bool isSureButton = false,
    String sureTitle = '确认',
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.white,
          child: TKActionAlert(
            title: title,
            content: contentStr,
            sureTitle: sureTitle,
            isSureButton: isSureButton,
            scrollable: false,
          ),
        );
      }
    );
  }
}

class TKActionAlert extends StatelessWidget {

  final String title;
  final String content;
  final String sureTitle;
  final bool isSureButton;
  final bool scrollable;

  TKActionAlert({
    Key key,
    this.title,
    this.content,
    this.sureTitle = '确认',
    this.scrollable = false,
    this.isSureButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeFit.screenWidth - 70.px,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren(context),
      ),
    );
  }

  List<Widget> columnChildren(BuildContext context) {
    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (title != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (title != null)
                    renderTitle(),
                  if (content != null)
                    renderContent(),
                ],
              ),
            ),
          ),
        renderActions(context),
      ];
    } else {
      columnChildren = <Widget>[
        if (title != null)
          renderTitle(),
        if (content != null)
          Flexible(child: renderContent()),
        renderActions(context),
      ];
    }

    return columnChildren;
  }

  Widget renderTitle() {
    if (title != null) {
      return Container(
        padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: Text(
          title, 
          textAlign: TextAlign.center, 
          style: TextStyle(fontSize: 17.px, color: TKColor.color_333333, fontWeight: FontWeight.w500)
        ),
      );
    }
    return null;
  }

  Widget renderContent() {
    if (content != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 16.0),
        child: Text(content, style: TextStyle(fontSize: 17.px, color: TKColor.color_333333))
      );
    }
    return null;
  }

  Widget renderActions(BuildContext context) {
    List<Widget> actions = [];
    if (!isSureButton) {
      final cancleButton = Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TKColor.color_e8e8e8, width: 0.5),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0))
          ),
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            child: Text('取消', style: TextStyle(fontSize: 16.px, color: TKColor.color_999999)),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
        ),
      );
      actions.add(cancleButton);
    }
    final sureButton = Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TKColor.color_e8e8e8, width: 0.5),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(0))
        ),
        child: RaisedButton(
          elevation: 0,
          color: Colors.transparent,
          child: Text(sureTitle, style: TextStyle(fontSize: 16.px, color: TKColor.main_color)),
          onPressed: () {

          }
        ),
      ),
    );
    actions.add(sureButton);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: actions,
      ),
    );
  }
}