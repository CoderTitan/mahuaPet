import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';

class TextSelectCell extends StatefulWidget {

  final double height;
  final double horizontalPadding;
  final Color backcolorColor;
  final String leftTitle;
  final String rightTitle;
  final double leftTitleFont;
  final double rightTitleFont;
  final Color leftTitleColor;
  final Color rightTitleColor;
  final GestureTapCallback onTap;
  final bool showLine;
  final bool showArrow;
  final double leftLineMargin;
  final Color lineColor;

  TextSelectCell({
    Key key,
    double height,
    double horizontalPadding,
    this.backcolorColor = Colors.white,
    this.leftTitle = '',
    this.rightTitle = '',
    double leftTitleFont,
    double rightTitleFont,
    this.leftTitleColor = TKColor.color_666666,
    this.rightTitleColor = TKColor.color_666666,
    this.onTap,
    this.showLine = true,
    this.showArrow = true,
    double leftLineMargin,
    this.lineColor = TKColor.color_e8e8e8,
  }): height = height ?? 56.px, 
    horizontalPadding = horizontalPadding ?? 16.px, 
    leftTitleFont = leftTitleFont ?? 16.px,
    rightTitleFont = rightTitleFont ?? 16.px,
    leftLineMargin = leftLineMargin ?? 16.px,
    super(key: key);



  @override
  _TextSelectCellState createState() => _TextSelectCellState();
}

class _TextSelectCellState extends State<TextSelectCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: widget.height,
        width: SizeFit.screenWidth,
        color: widget.backcolorColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: childrenItem(),
        ),
      ),
      onTap: widget.onTap,
    );
  }

  List<Widget> childrenItem() {
    List<Widget> itemList = [];

    Widget topItem = Container(
      height: widget.height - 0.5,
      width: SizeFit.screenWidth,
      color: widget.backcolorColor,
      padding: EdgeInsets.only(left: widget.horizontalPadding, right: widget.showArrow ? 6.px : 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              widget.leftTitle, 
              style: TextStyle(fontSize: widget.leftTitleFont, color: widget.leftTitleColor)
            )
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: childrenRowItem(),
            )
          )
        ],
      ),
    );
    itemList.add(topItem);

    if (widget.showLine) {
      itemList.add(
        Container(
          padding: EdgeInsets.only(left: widget.leftLineMargin),
          width: SizeFit.screenWidth - widget.leftLineMargin,
          height: 0.5,
          color: widget.lineColor,
        )
      );
    }
    
    return itemList;
  }

  List<Widget> childrenRowItem() {
    List<Widget> itemList = [];

    Widget textInput = Text(
      widget.rightTitle, 
      textAlign: TextAlign.end, 
      style: TextStyle(fontSize: widget.rightTitleFont, color: widget.rightTitleColor)
    );
    itemList.add(textInput);
    if (widget.showArrow) {
      itemList.add(Icon(Icons.keyboard_arrow_right, color: TKColor.color_cccccc, size: 28.px));
    }

    return itemList;
  }
}