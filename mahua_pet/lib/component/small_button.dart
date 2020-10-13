import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';


class SmallButton extends StatelessWidget {
  final bool disabled;
  final String title;
  final EdgeInsets padding;
  final Color backgroundColor;
  final VoidCallback onPressed;

  SmallButton({
    @required VoidCallback onPressed,
    this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.disabled = true,
    this.backgroundColor = TKColor.main_color
  }): onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        padding: padding,
        child: Text(title, style: TextStyle(fontSize: 13.px)),
        textColor: TKColor.color_4b4b4b,
        disabledTextColor: TKColor.color_6f6f6f,
        color: backgroundColor,
        disabledColor: TKColor.color_ffea9e,
        shape: StadiumBorder(),
        elevation: 1,
        onPressed: disabled ? onPressed : null,
      ),
    );
  }
}