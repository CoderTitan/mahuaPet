import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';

class LoginInput extends StatefulWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final double leftWidth;
  final TextInputType keyboardType;
  final String leftTitle;
  final int maxLength;
  final bool autofocus;
  final bool showObscure;
  final TextCleanType cleanType;
  final String placeText;
  final Widget suffix;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  LoginInput({
    Key key,
    @required this.leftTitle,
    TextEditingController controller,
    FocusNode focusNode,
    this.leftWidth = 65,
    this.keyboardType,
    this.maxLength,
    this.autofocus = false,
    this.showObscure = false,
    this.cleanType = TextCleanType.whileEditing,
    this.placeText,
    this.suffix,
    this.onSubmitted,
    this.onChanged,
  }): controller = controller ?? TextEditingController(),
    focusNode = focusNode ?? FocusNode(),
    super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Container(
        height: 50.px,
        width: SizeFit.screenWidth - 30.px,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: TKColor.color_e8e8e8))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: widget.leftWidth,
              child: Text(widget.leftTitle, style: TextStyle(fontSize: 16.px, color: TKColor.color_666666)),
            ),
            Expanded(
              child: TextInput(
                keyboardType: widget.keyboardType,
                focusNode: widget.focusNode,
                controller: widget.controller,
                maxLines: 1,
                maxLength: widget.maxLength,
                autofocus: widget.autofocus,
                showObscure: widget.showObscure,
                cleanType: widget.cleanType,
                suffix: widget.suffix,
                style: TextStyle(fontSize: 18.px, color: TKColor.color_333333),
                placeText: widget.placeText,
                placeStyle: TextStyle(fontSize: 16.px, color: TKColor.color_cccccc),
                onChanged: (text) {
                  widget.onChanged(text);
                },
                onSubmitted: (text) {
                  widget.onSubmitted(text);
                  widget.focusNode.unfocus();
                },
              ),
            ),
          ],
        )
      )
    );
  }
}