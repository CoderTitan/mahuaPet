import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/home/contents/calendar_page.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'views/home_list.dart';


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
        renderHeader(),
        HomeList()
      ],
    );
  }

  Widget renderHeader() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 250.px + SizeFit.statusHeight,
            child: Stack(
              children: <Widget>[
                initBackImage(),
                initRightSelect(),
                initAnimalInfo(),
                initAnimalLifes()
              ],
            ),
          ),
          IconButton(
            iconSize: 18.px,
            icon: Image.asset('${TKImages.image_path}calendar.png'), 
            onPressed: () {
              Navigator.of(context).pushNamed(CalendarPage.rooteName);
            }
          )
        ],
      ),
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
      top: 10.px + SizeFit.statusHeight,
      child: GestureDetector(
        child: Image.asset(
          '${TKImages.image_path}home_animal.png', 
          width: 90.px,
          height: 37.px,
        ),
        onTap: () => selectAnimal(),
      )
    );
  }

  Widget initAnimalInfo() {
    return Positioned(
      left: 20.px,
      top: 60.px,
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
              Text.rich(TextSpan(children: [
                WidgetSpan(
                  child: Text('麻花宠物', style: TextStyle(fontSize: 18.px, color: TKColor.color_333333, fontWeight: FontWeight.w600, height: 1.3)),
                  // style: ,
                  alignment: PlaceholderAlignment.middle
                ),
                WidgetSpan(
                  child: Image.asset('${TKImages.image_path}animal_cat.png', width: 20.px, height: 20.px),
                  baseline: TextBaseline.ideographic,
                  alignment: PlaceholderAlignment.middle
                )
              ])),
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
    final titles = ['日常打卡', '提醒吧', '健康管理', '体重记录', '相册'];
    final images = ['home_record.png', 'home_warn.png', 'home_fit.png', 'home_weight.png', 'home_album.png'];
    return Positioned(
      bottom: 0,
      left: 15.px,
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 100.px,
        // padding: EdgeInsets.symmetric(horizontal: 10.px),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.px)),
          boxShadow: [
            BoxShadow(color: TKColor.color_b6b6b6, offset: Offset(-2, -2), blurRadius: 5.px),
            BoxShadow(color: TKColor.color_b6b6b6, offset: Offset(2, 2), blurRadius: 5.px),
          ]
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: titles.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                child: Container(
                  width: 75.px,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('${TKImages.image_path}${images[index]}', width: 38.px, height: 38.px, fit: BoxFit.contain),
                      SizedBox(height: 8.px),
                      Text(titles[index], style: TextStyle(fontSize: 13.px, color: TKColor.color_333333)),
                    ],
                  ),
                ),
                onTap: () => headerItemClick(index),
              );
            }
          ),
      ),
    );
  }

  void selectAnimal() {

  }

  void headerItemClick(index) {
    print('index = $index');
  }
}