import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';

import '../models/model_index.dart';


class FindBottomTool extends StatelessWidget {


  final FocusNode focusNode;
  final TextEditingController controller;
  final ActionTextSubmit submitAction;
  final FindActionCallBack actionCallback;
  final bool agreeState;
  final bool collectionState;
  final String agreeCount;
  final String collectionCount;
  final Color backcolorColor;
  final Color inputBackColor;
  final Color mainColor;
  final bool showBorder;


  FindBottomTool({
    this.focusNode,
    this.controller,
    this.submitAction,
    this.actionCallback,
    this.agreeState = false,
    this.collectionState = false,
    this.agreeCount = '0',
    this.collectionCount = '0',
    this.backcolorColor = TKColor.white,
    this.mainColor = TKColor.color_666666,
    this.inputBackColor = TKColor.color_f7f7f7,
    this.showBorder = true,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.px,
      color: backcolorColor,
      padding: EdgeInsets.only(bottom: 0, right: 0.px),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 12.px, right: 30.px, top: 7.px, bottom: 7.px),
                decoration: BoxDecoration(
                  color: inputBackColor,
                  borderRadius: BorderRadius.circular(20.px)
                ),
                child: Text('快来评论小可爱吧...', style: TextStyle(fontSize: 15.px, color: mainColor)),
              ),
              onTap: () {
                TKActionComment.showActionSheet(
                  context,
                  focusNode: focusNode,
                  textController: controller,
                  placehold: '快来评论小可爱吧...',
                  submitAction: (text) {
                    submitAction(text);
                  }
                );
              },
            ),
            Row(
              children: <Widget>[
                bottomItem(
                  agreeState ? Icons.favorite : Icons.favorite_border, 
                  agreeState ? TKColor.main_color : mainColor, 
                  agreeCount, 0
                ),
                SizedBox(width: 30.px),
                bottomItem(
                  collectionState ? Icons.star : Icons.star_border, 
                  collectionState ? TKColor.main_color : mainColor, 
                  collectionCount, 1
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomItem(IconData icon, Color iconColor, String number, int index) {
    return GestureDetector(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 20.px, color: iconColor,),
            Text('$number', style: TextStyle(fontSize: 13.px, color: mainColor))
          ],
        ),
      ),
      onTap: () {
        if (index == 0) {
          actionCallback(FindActionType.agree);
        } else if (index == 1) {
          actionCallback(FindActionType.collection);
        }
      },
    );
  }
}