import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';


class FocusButton extends StatelessWidget {
  final bool isSelect;
  final VoidCallback onPressed;

  FocusButton({
    @required VoidCallback onPressed,
    this.isSelect = false,
  }): onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 3.px),
        decoration: BoxDecoration(
          color: isSelect ? TKColor.color_ffea9e_33 : TKColor.main_color,
          borderRadius: BorderRadius.circular(20.px),
          border: Border.all(color: TKColor.main_color, width: 0.5)
        ),
        child: Text(
          isSelect ? '已关注' : '+关注', 
          style: TextStyle(
            fontSize: 12.px, 
            color: isSelect ? TKColor.main_color : TKColor.white
          )
        ),
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}