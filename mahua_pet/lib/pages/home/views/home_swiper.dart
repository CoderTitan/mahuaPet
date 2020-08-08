import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/home/models/swiper_model.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeSwiper extends StatefulWidget {
  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (ctx, homeVM, child) {
        final swipers = homeVM.swiperArray ?? [];
        return Container(
          height: 120.px,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              CarouselSlider(
                items: renderItems(swipers), 
                options: CarouselOptions(
                  height: 100.px,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  onPageChanged: (i, page) {
                    setState(() {
                      _currentIndex = i;
                    });
                  }
                )
              ),
              SizedBox(height: 5.px),
              Container(
                width: 50.px,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: swipers.map((e) {
                    final index = swipers.indexOf(e);
                    return Container(
                      width: 5.px,
                      height: 5.px,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? TKColor.main_color: TKColor.color_e5e5e5,
                        borderRadius: BorderRadius.circular(4.px)
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> renderItems(List<SwiperModel> models) {
    return models.map((item) => Container(
      padding: EdgeInsets.only(top: 5.px),
      color: Colors.white,
      child: Center(
        child: TKNetworkImage(
          imageUrl: item.directImg,
          width: SizeFit.screenWidth - 32.px,
          height: 100.px,
          fit: BoxFit.cover,
          placeholder: TKImages.image_path + 'find_swiper_banner.png',
        ),
      ),
    )).toList();
  }
}

