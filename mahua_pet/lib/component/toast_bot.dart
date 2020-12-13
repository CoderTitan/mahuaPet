import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/styles/app_style.dart';

class BTToast {

  /// 点按位置弹窗
  static void showAttached(BuildContext context, List<String> rows, void Function(String, int) callback) {
    final titles = rows ?? [];
    
    // BotToast.showAttachedWidget(
    //   duration: null,
    //   targetContext: context,
    //   attachedBuilder: (cancelFunc) => Card(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 8.px),
    //       height: 40.px * titles.length,
    //       child: Column(
    //         children: titles.map((e) {
    //           final index = titles.indexOf(e);
    //           return GestureDetector(
    //             child: Container(
    //               height: 40.px,
    //               width: 80.px,
    //               alignment: Alignment.center,
    //               child: Text(e, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)),
    //               decoration: BoxDecoration(
    //                 border: Border(
    //                   bottom: BorderSide(
    //                     color: TKColor.color_e8e8e8, 
    //                     width: index == titles.length - 1 ? 0 : 0.5
    //                   )
    //                 )
    //               ),
    //             ),
    //             onTap: () {
    //               cancelFunc();
    //               callback(e, index);
    //             },
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );
  }
}