import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';

class AuthCodeButton extends StatefulWidget {
  final int timeCount;
  final VoidCallback? onPressed;
  final VoidCallback? endActoon;

  AuthCodeButton({
    Key? key,
    required this.onPressed,
    this.timeCount = 0,
    this.endActoon,
  }) : super(key: key);

  @override
  AuthCodeButtonState createState() => AuthCodeButtonState();
}

class AuthCodeButtonState extends State<AuthCodeButton> {
  String title = '获取验证码';
  bool isDisable = true;

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.px,
      child: Center(
        child: SizedBox(
          width: 90.px,
          height: 30.px,
          child: TextButton(
            child: Text(title,
                style: TextStyle(
                    fontSize: 13.px,
                    color: isDisable
                        ? TKColor.color_4b4b4b
                        : TKColor.color_6f6f6f)),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 2.px)),
                backgroundColor: MaterialStateProperty.all(
                    isDisable ? TKColor.main_color : TKColor.color_ffea9e),
                shape: MaterialStatePropertyAll(StadiumBorder())),
            onPressed: isDisable ? widget.onPressed : null,
          ),
        ),
      ),
    );
  }

  void startAction() {
    int counter = widget.timeCount;
    setState(() {
      title = '${counter}s';
      isDisable = false;
    });

    if (_timer != null) {
      return;
    }

    // 开始倒计时
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter--;
      if (counter <= 0) {
        if (widget.endActoon != null) {
          widget.endActoon!();
        }
        setState(() {
          title = '重新获取';
          isDisable = true;
        });
        _timer?.cancel();
        _timer = null;
      } else {
        setState(() {
          title = '${counter}s';
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }
}
