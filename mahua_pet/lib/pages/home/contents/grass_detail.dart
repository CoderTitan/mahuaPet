import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/grass_model.dart';
import '../request/home_request.dart';


typedef GrassCallBack = void Function(GrassModel grassModel);

class GrassDetail extends StatefulWidget {
  final int trialId;
  final GrassCallBack callback;
  GrassDetail({@required this.trialId, this.callback});

  @override
  _GrassDetailState createState() => _GrassDetailState();
}

class _GrassDetailState extends State<GrassDetail> {

  GrassModel model;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    loadGrassData();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                child: Icon(Icons.share),
                onTap: () {
                  
                },
              ),
              SizedBox(width: 16.px),
            ],
          ),
          body: renderContain(store.state),
        );
      },
    );
  }

  Widget renderContain(TKState state) {
    if (model == null) {
      return EmptyContent(showReload: false);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderUserInfoItem(state),
          renderTitleItem(state),
          renderTopicItem(state),
          renderImageList(state),
          renderMessageItem(state),
          renderBottomItem(state)
        ],
      ),
    );
  }

  Widget renderUserInfoItem(TKState state) {
    final isNight = state.isNightModal;
    return Container(
      padding: EdgeInsets.all(16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TKNetworkImage(
                imageUrl: model.headImg ?? '',
                width: 40, height: 40,
                boxRadius: 40,
                fit: BoxFit.cover,
                placeholder: TKImages.user_header,
              ),
              SizedBox(width: 8.px),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.nickname, style: TextStyle(fontSize: 12.px, color: TKColor.font33(isNight))),
                  SizedBox(height: 2.px),
                  Text(model.createTime, style: TextStyle(fontSize: 12.px, color: TKColor.font33(isNight)))
                ],
              )
            ],
          ),
          renderFocusButton()
        ],
      ),
    );
  }

  Widget renderFocusButton() {
    if (model.isSelf) return Container();
    return FocusButton(
      isSelect: model.followStatus == '已关注',
      onPressed: () {}
    );
  }

  Widget renderTitleItem(TKState state) {
    final isNight = state.isNightModal;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Text(model.reportTitle, style: TextStyle(fontSize: 16.px, color: TKColor.font33(isNight))),
    );
  }

  Widget renderTopicItem(TKState state) {
    final isNight = state.isNightModal;
    final mainColor = isNight ? TKColor.white : state.themeData.primaryColor;
    if (model.labelName == null || model.labelName == '') {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
      decoration: BoxDecoration(
        color: TKColor.marginColor(isNight),
        borderRadius: BorderRadius.circular(2.px),
      ),
      child: Text('#' + model.labelName ?? '', style: TextStyle(fontSize: 10.px, color: mainColor)),
    );
  }

  Widget renderImageList(TKState state) {
    return Container(
      height: 180.px,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            items: model.fileList.map((e) {
              return TKNetworkImage(
                imageUrl: e.fileUrl,
                width: SizeFit.screenWidth,
                height: 180.px,
                fit: BoxFit.cover,
                placeholder: TKImages.image_path + 'find_swiper_banner.png',
              );
            }).toList(), 
            options: CarouselOptions(
              height: 180.px,
              viewportFraction: 1,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 2),
              onPageChanged: (i, page) {
                setState(() {
                  _currentIndex = i;
                });
              }
            )
          ),
          Positioned(
            bottom: 10.px,
            child: renderIndictor(state)
          )
        ],
      ),
    );
  }

  Widget renderIndictor(TKState state) {
    final isNight = state.isNightModal;
    final mainColor = isNight ? TKColor.color_999999 : state.themeData.primaryColor;
    return Container(
      width: SizeFit.screenWidth - 16.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: model.fileList.map((e) {
          final index = model.fileList.indexOf(e);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.px),
            child: Container(
              width: 5.px,
              height: 5.px,
              decoration: BoxDecoration(
                color: _currentIndex == index ? mainColor : TKColor.white,
                borderRadius: BorderRadius.circular(4.px)
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget renderMessageItem(TKState state) {
    final isNight = state.isNightModal;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      child: Text(
        model.messageInfo,
        style: TextStyle(fontSize: 14.px, color: TKColor.font66(isNight)),
      ),
    );
  }

  Widget renderBottomItem(TKState state) {
    final isNight = state.isNightModal;
    final mainColor = isNight ? TKColor.font33(true) : state.themeData.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      margin: EdgeInsets.only(bottom: SizeFit.safeHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Row(
              children: [
                Icon(
                  model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border, 
                  color: mainColor
                ),
                SizedBox(width: 4.px),
                Text(model.messageAgreenum, style: TextStyle(fontSize: 14.px, color: TKColor.font66(isNight)))
              ],
            ),
            onTap: () {
              loadAgree();
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(model.collectionStatus == '1' ? Icons.star: Icons.star_border, color: mainColor),
                SizedBox(width: 4.px),
                Text(model.collectionCount, style: TextStyle(fontSize: 14.px, color: TKColor.font66(isNight)))
              ],
            ),
            onTap: () {
              loadCollection();
            },
          )
        ],
      ),
    );
  }

  void loadGrassData() {
    HomeRequest.loadGrassDetail(widget.trialId).then((value) {
      setState(() {
        model = value;
      });
    });
  }

  void loadAgree() {
    HomeRequest.loadGrassAgree(widget.trialId, int.parse(model.agreeStatus))
      .then((value) {
        if (model.agreeStatus == '1') {
          model.agreeStatus = '0';
          model.messageAgreenum = '${int.parse(model.messageAgreenum) - 1}';
        } else {
          model.agreeStatus = '1';
          model.messageAgreenum = '${int.parse(model.messageAgreenum) + 1}';
        }
        setState(() {});
        widget.callback(model);
      });
  }

  void loadCollection() {
    HomeRequest.loadGrassCollect(widget.trialId, int.parse(model.collectionStatus))
      .then((value) {
        if (model.collectionStatus == '1') {
          model.collectionStatus = '0';
          model.collectionCount = '${int.parse(model.collectionCount) - 1}';
        } else {
          model.collectionStatus = '1';
          model.collectionCount = '${int.parse(model.collectionCount) + 1}';
        }
        setState(() {});
        widget.callback(model);
      });
  }
}