import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';


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
        padding: EdgeInsets.symmetric(horizontal: 10.px),
        decoration: BoxDecoration(
          color: isSelect ? TKColor.color_ffea9e_33 : TKColor.main_color,
          borderRadius: BorderRadius.circular(20.px),
          border: Border.all(color: TKColor.main_color, width: 0.5)
        ),
        child: Text(
          isSelect ? S.of(context).find_focused : ('+' + S.of(context).mine_flower), 
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