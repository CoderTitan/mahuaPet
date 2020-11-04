
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mahua_pet/styles/app_style.dart';



typedef VoidCallBack = void Function();


class TKActionAlert {
  /// 中间弹出弹窗
  static showCenter(BuildContext context, {
    @required Widget child,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (ctx) {
        return GestureDetector(
          child: Container(
            color: Colors.black38,
            child: Center(child: child),
          ),
          onTap: () {
            if (barrierDismissible) {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }
          },
        );
      },
    );
  }

  
  // 中间显示的取消/确认弹窗
  static showAlert({
    @required BuildContext context, 
    String title,
    String message,
    String leftTitle,
    String rightTitle,
    VoidCallBack leftPressed,
    VoidCallBack rightPressed,
  }) {
    if (SizeFit.isIOS) {
      showCupertinoDialog(
        context: context, 
        builder: (ctx) {
          return _CupertinoAlert(
            context: context,
            title: title,
            message: message,
            leftTitle: leftTitle,
            rightTitle: rightTitle,
            leftPressed: leftPressed,
            rightPressed: rightPressed,
          );
        }
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return _MaterialAlert(
            context: context,
            title: title,
            message: message,
            leftTitle: leftTitle,
            rightTitle: rightTitle,
            leftPressed: leftPressed,
            rightPressed: rightPressed,
          );
        }
      );
    }
  }

  /// 列表List
  static Future<Null> showCommitOptionDialog({
    @required BuildContext context,
    List<Color> colorList,
    double width = 250.0,
    bool isNight = false,
    List<String> titleList,
    ValueChanged<int> onTap
  }) {
    final titleArray = titleList ?? [];
    final colorArray = colorList ?? [];
    return showTKDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            width: width,
            height: titleArray.length * 44.px + 8.px,
            padding: EdgeInsets.all(4.px),
            margin: EdgeInsets.all(20.px),
            decoration: BoxDecoration(
              color: TKColor.whiteColor(isNight),
              borderRadius: BorderRadius.circular(4.px)
            ),
            child: ListView.builder(
              itemCount: titleArray.length,
              itemBuilder: (ctx, index) {
                final backColor = colorArray.length > 0 ? colorArray[index] : (isNight ? TKColor.color_151b26 : TKColor.white);
                final textColor = (colorArray.length > 0 || isNight) ? TKColor.white : TKColor.color_1a1a1a;
                return RaisedButton(
                  textColor: Colors.white,
                  color: backColor,
                  child: Text(titleArray[index], style: TextStyle(fontSize: 14.px, color: textColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onTap(index);
                  },
                );
              },
            ),
          ),
        );
      }
    );
  }

  ///弹出 dialog
  static Future<T> showTKDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return MediaQuery(
          ///不受系统字体缩放影响
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(textScaleFactor: 1),
          child: SafeArea(child: builder(context))
        );
      }
    );
  }
}

class _CupertinoAlert extends StatelessWidget {

  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _CupertinoAlert({
    @required BuildContext context,
    this.title = '',
    this.message = '',
    this.leftTitle = '取消',
    this.rightTitle = '确认',
    this.leftPressed,
    this.rightPressed
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? '', style: TextStyle(fontSize: 17.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.bold)),
      content: Container(
        padding: EdgeInsets.only(top: 8.px),
        child: Text(message ?? '', style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)),
      ),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = CupertinoDialogAction(
      textStyle: TextStyle(fontSize: 16.px, color: TKColor.color_999999),
      child: Text(leftTitle ?? '取消'),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = CupertinoDialogAction(
        textStyle: TextStyle(fontSize: 16.px, color: TKColor.main_color),
        child: Text(rightTitle),
        onPressed: () {
          Navigator.of(context).pop();
          if (rightPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}

class _MaterialAlert extends StatelessWidget {

  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _MaterialAlert({
    @required BuildContext context,
    this.title = '',
    this.message = '',
    this.leftTitle = '取消',
    this.rightTitle = '确认',
    this.leftPressed,
    this.rightPressed
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      titleTextStyle: TextStyle(fontSize: 17.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.bold),
      // titlePadding: EdgeInsets.only(top: 8.px),
      content: Text(message ?? ''),
      contentTextStyle: TextStyle(fontSize: 15.px, color: TKColor.color_333333),
      // contentPadding: EdgeInsets.only(top: 8.px),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = FlatButton(
      child: Text(leftTitle ?? '取消', style: TextStyle(fontSize: 16.px, color: TKColor.color_999999)),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = FlatButton(
        child: Text(rightTitle, style: TextStyle(fontSize: 16.px, color: TKColor.main_color)),
        onPressed: () {
          Navigator.of(context).pop();
          if (leftPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}