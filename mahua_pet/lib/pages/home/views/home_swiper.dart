import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (ctx, homeVM, child) {
        return CarouselSlider(
          items: null, 
          options: null
        );
      },
    );
  }
}






/**

@override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeFit.screenWidth,
      height: 150.px,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      child: Consumer<HomeViewModel>(
        builder: (ctx, homeVM, child) {
          final swipers = homeVM.swiperArray;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: swipers.length,
            itemBuilder: (ctx, i) {
              final model = swipers[i];
              return Container(
                child: TKNetworkImage(
                  imageUrl: model.directImg,
                  width: 70.px, height: 70.px,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  borderRadius: 35.px,
                  showProgress: true,
                  fit: BoxFit.cover,
                  placeholder: '${TKImages.image_path}animal_icon.png',
                ),
              );
            }
          );
        }
      ),
    );
  }
 */