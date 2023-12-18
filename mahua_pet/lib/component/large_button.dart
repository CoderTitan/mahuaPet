import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';

class LargeButton extends StatelessWidget {
  final bool disabled;
  final String title;
  final VoidCallback? onPressed;

  LargeButton({
    required this.onPressed,
    this.title = '',
    this.disabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 50.px,
        child: TextButton(
          child: Text(title,
              style: TextStyle(
                  fontSize: 13.px,
                  color:
                      disabled ? TKColor.color_4b4b4b : TKColor.color_6f6f6f)),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 2.px)),
              backgroundColor: MaterialStateProperty.all(
                  disabled ? TKColor.main_color : TKColor.color_ffea9e),
              shape: MaterialStatePropertyAll(StadiumBorder())),
          onPressed: disabled ? onPressed : null,
        ),
      ),
    );
  }
}
