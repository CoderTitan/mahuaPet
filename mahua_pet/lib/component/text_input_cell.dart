import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'text_input.dart';

class TextInputCell extends StatefulWidget {

  final double height;
  final double horizontalPadding;
  final Color backcolorColor;
  final String leftTitle;
  final double leftTitleFont;
  final Color leftTitleColor;
  final String placeholder;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final double inputFont;
  final ValueChanged<String> onChanged;
  final bool showLine;
  final bool showArrow;
  final double leftLineMargin;
  final Color lineColor;

  TextInputCell({
    Key key,
    double height,
    double horizontalPadding,
    this.backcolorColor = Colors.white,
    this.leftTitle,
    double leftTitleFont,
    this.leftTitleColor = TKColor.color_666666,
    this.placeholder,
    this.focusNode,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    double inputFont,
    this.onChanged,
    this.showLine = true,
    this.showArrow = true,
    double leftLineMargin,
    this.lineColor = TKColor.color_e8e8e8,
  }): height = height ?? 56.px, 
    horizontalPadding = horizontalPadding ?? 16.px, 
    leftTitleFont = leftTitleFont ?? 16.px,
    inputFont = inputFont ?? 16.px,
    leftLineMargin = leftLineMargin ?? 16.px,
    super(key: key);



  @override
  _TextInputCellState createState() => _TextInputCellState();
}

class _TextInputCellState extends State<TextInputCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: SizeFit.screenWidth,
      color: widget.backcolorColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childrenItem(),
      ),
    );
  }

  List<Widget> childrenItem() {
    List<Widget> itemList = [];

    Widget topItem = Container(
      height: widget.height - 0.5,
      width: SizeFit.screenWidth,
      color: widget.backcolorColor,
      child: Padding(
        padding: EdgeInsets.only(left: widget.horizontalPadding, right: widget.showArrow ? 6.px : 16.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: childrenRowItem(),
        ),
      ),
    );
    itemList.add(topItem);

    if (widget.showLine) {
      itemList.add(
        Padding(
          padding: EdgeInsets.only(left: widget.leftLineMargin),
          child: Container(
            width: SizeFit.screenWidth - widget.leftLineMargin,
            height: 0.5,
            color: widget.lineColor,
          )
        )
      );
    }
    
    return itemList;
  }

  List<Widget> childrenRowItem() {
    List<Widget> itemList = [];

    Text leftTitle = Text(widget.leftTitle, style: TextStyle(fontSize: widget.leftTitleFont, color: widget.leftTitleColor));
    itemList.add(leftTitle);

    Widget input = Expanded(child: Row(
      children: childrenRightRowItem(),
    ));
    itemList.add(input);

    return itemList;
  }

  List<Widget> childrenRightRowItem() {
    List<Widget> itemList = [];

    Widget textInput = Expanded(
      child: TextInput(
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: TextStyle(fontSize: widget.inputFont, color: TKColor.color_333333),
        placeText: widget.placeholder,
        placeStyle: TextStyle(fontSize: widget.inputFont, color: TKColor.color_cccccc),
        textAlign: TextAlign.end,
        maxLength: widget.maxLength,
        onChanged: (text) => widget.onChanged(text),
      ),
    );
    itemList.add(textInput);
    if (widget.showArrow) {
      itemList.add(Icon(Icons.keyboard_arrow_right, color: TKColor.color_cccccc, size: 28.px));
    }

    return itemList;
  }
}