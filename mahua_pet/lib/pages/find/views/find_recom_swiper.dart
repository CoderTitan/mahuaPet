import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../models/find_topic_model.dart';
import '../contents/find_swiper_content.dart';



class FindTopicSwiper extends StatefulWidget {
  final List<FindTopicModel> topics;
  FindTopicSwiper({
    List<FindTopicModel> topics,
  }): topics = topics ?? [];

  @override
  _FindTopicSwiperState createState() => _FindTopicSwiperState();
}

class _FindTopicSwiperState extends State<FindTopicSwiper> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.px,
      child: Stack(
        children: <Widget>[
          renderHeaderItem(),
          Positioned(
            bottom: 10.px,
            child: renderIndictor()
          )
        ],
      ),
    );
  }

  Widget renderHeaderItem() {
    return CarouselSlider(
      items: renderItems(), 
      options: CarouselOptions(
        height: 130.px,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        onPageChanged: (i, page) {
          setState(() {
            _currentIndex = i;
          });
        }
      )
    );
  }

  List<Widget> renderItems() {
    return widget.topics.map((item) => Container(
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            TKNetworkImage(
              imageUrl: item.labelImg,
              width: SizeFit.screenWidth - 16.px,
              height: 130.px,
              fit: BoxFit.cover,
              placeholder: TKImages.image_path + 'find_swiper_banner.png',
            ),
            Positioned(
              left: 0, right: 0, top: 0, bottom: 0,
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.black26)), 
            ),
            Positioned(
              left: 8.px, right: 8.px, top: 8.px,
              child: Container(
                child: Text(item.labelName, style: TextStyle(fontSize: 13.px, color: TKColor.white), textAlign: TextAlign.center),
              ),
            ),
            Positioned(
              left: 8.px, right: 8.px, bottom: 0.px,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    renderBottomItem(0, item),
                    renderBottomItem(1, item),
                  ],
                )
              ),
            ),
          ],
        ),
        onTap: () {
          TKRoute.push(context, FindSwiperPage(model: item));
        },
      ),
    )).toList();
  }

  Widget renderBottomItem(int index, FindTopicModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(index == 0 ? Icons.message : Icons.remove_red_eye, color: TKColor.white, size: 14.px),
        SizedBox(width: 4.px),
        Text(
          index == 0 ? '${model.userCount}' : '${model.readNUm}', 
          style: TextStyle(fontSize: 14.px, color: TKColor.white),
          textAlign: index == 0 ? TextAlign.left : TextAlign.right,
        )
      ],
    );
  }

  Widget renderIndictor() {
    return Container(
      width: SizeFit.screenWidth - 16.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.topics.map((e) {
          final index = widget.topics.indexOf(e);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.px),
            child: Container(
              width: 5.px,
              height: 5.px,
              decoration: BoxDecoration(
                color: _currentIndex == index ? TKColor.main_color: TKColor.white,
                borderRadius: BorderRadius.circular(4.px)
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

