import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';

class GrowthAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titles = [S.of(context).home_card, S.of(context).home_fit, S.of(context).home_weight];
    final images = ['home_record', 'home_fit', 'home_weight'];
    return Container(
      height: SizeFit.safeHeight + 120,
      padding: EdgeInsets.only(bottom: SizeFit.safeHeight, top: 35.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.px))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: images.map((e) {
          final index = images.indexOf(e) ?? 0;
          return GestureDetector(
            child: Column(
              children: [
                Image.asset(TKImages.asset(e), width: 30.px, height: 30.px),
                SizedBox(height: 6.px,),
                Text(titles[index], style: TextStyle(fontSize: 12.px, color: TKColor.color_333333))
              ],
            ),
            onTap: () {
              jumpRecord(index);
            },
          );
        }).toList(),
      ),
    );
  }

  void jumpRecord(int index) {
    if (index == 0) {
      
    } else {
    }
  }
}