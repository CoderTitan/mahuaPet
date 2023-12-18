import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';

class SmallButton extends StatelessWidget {
  final bool disabled;
  final String title;
  final EdgeInsets padding;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  SmallButton(
      {required VoidCallback onPressed,
      this.title = '',
      this.padding = const EdgeInsets.symmetric(horizontal: 8),
      this.disabled = true,
      this.backgroundColor = TKColor.main_color})
      : onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text(title,
            style: TextStyle(
                fontSize: 13.px,
                color: disabled ? TKColor.color_4b4b4b : TKColor.color_6f6f6f)),
        style: ButtonStyle(
            elevation: MaterialStatePropertyAll(1),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 2.px)),
            backgroundColor: MaterialStateProperty.all(
                disabled ? backgroundColor : TKColor.color_ffea9e),
            shape: MaterialStatePropertyAll(StadiumBorder())),
        onPressed: disabled ? onPressed : null,
      ),
    );
  }
}
