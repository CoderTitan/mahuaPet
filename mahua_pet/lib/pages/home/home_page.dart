import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: TKColor.color_f7f7f7,
      height: SizeFit.screenHeight,
      child: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: 250.px + SizeFit.statusHeight,
            color: TKColor.color_ff4040,
            child: Stack(
              children: <Widget>[
                initBackImage(),
                initRightSelect(),
                initAnimalInfo(),
                initAnimalLifes()
              ],
            ),
          ),
        ),
        
      ],
    );
  }

  Widget initBackImage() {
    return Image.asset(
      '${TKImages.image_path}home_back.png', 
      width: SizeFit.screenWidth, 
      height: 200.px + SizeFit.statusHeight, 
      fit: BoxFit.fill
    );
  }

  Widget initRightSelect() {
    return Positioned(
      right: 15.px,
      top: SizeFit.statusHeight + 10.px,
      child: GestureDetector(
        child: Image.asset(
          '${TKImages.image_path}home_animal.png', 
          width: 90.px,
          height: 37.px,
        ),
        onTap: () {

        },
      )
    );
  }

  Widget initAnimalInfo() {
    return Positioned(
      left: 20.px,
      top: 60.px + SizeFit.statusHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70.px, height: 70.px,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('${TKImages.image_path}animal_icon.png'))
            ),
          ),
          SizedBox(width: 16.px),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('麻花宠物', style: TextStyle(fontSize: 18.px, color: TKColor.color_333333, fontWeight: FontWeight.w600, height: 1.3)),
              SizedBox(height: 2.px),
              Text('已陪伴356天', style: TextStyle(fontSize: 13.px, color: TKColor.color_333333, height: 1.3)),
              Text('1岁6个月|比熊|3kg', style: TextStyle(fontSize: 13.px, color: TKColor.color_333333, height: 1.3)),
            ],
          )
        ],
      ),
    );
  }

  Widget initAnimalLifes() {
    
    // final titles = ['日常打卡', '提醒吧', '健康管理', '体重记录', '相册'];
    // final images = ['add_days_record.png', 'add_warning.png', 'add_fitness.png', 'add_weight.png', 'add_camera.png'];
    return Positioned(
      bottom: 0,
      left: 15.px,
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 100.px,
        child: Card(
          color: Colors.white,
          shadowColor: TKColor.color_e8e8e8,
          elevation: 4,
          child: Container(),
        ),
      ),
    );
  }
}