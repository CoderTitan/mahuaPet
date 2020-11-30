import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';


class LargeButton extends StatelessWidget {
  final bool disabled;
  final String title;
  final VoidCallback onPressed;

  LargeButton({
    @required VoidCallback onPressed,
    this.title,
    this.disabled,
  }): onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 50.px,
        child: RaisedButton(
          child: Text(title ?? '', style: TextStyle(fontSize: 16.px)),
          textColor: TKColor.color_4b4b4b,
          disabledTextColor: TKColor.color_6f6f6f,
          color: TKColor.main_color,
          disabledColor: TKColor.color_ffea9e,
          shape: StadiumBorder(),
          onPressed: disabled ? onPressed : null,
        ),
      ),
    );
  }
}