
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../models/record_list_model.dart';


class CardRecordShareItem extends StatelessWidget {

  final List<RecordListModel> models;

  CardRecordShareItem({this.models});

  final GlobalKey imageGlobal = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        final petModel = store.state.currentPet ?? PetModel();
        return Material(
          color: Colors.transparent,
          child: Container(
            height: 445.px,
            margin: EdgeInsets.symmetric(horizontal: 45.px),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderInfoItem(petModel),
                SizedBox(height: 15.px),
                renderBottomItem(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget renderInfoItem(PetModel model) {
    return RepaintBoundary(
      key: imageGlobal,
      child: Container(
        child: Column(
          children: [
            renderTopItem(model),
            renderMiddleItem()
          ],
        ),
      ),
    );
  }

  Widget renderTopItem(PetModel model) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: TKColor.color_ffe277,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.px, top: 20.px),
            child: Row(
              children: [
                TKNetworkImage(
                  imageUrl: model.petImg,
                  width: 60.px, height: 60.px,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  boxRadius: 40,
                  showProgress: true,
                  fit: BoxFit.cover,
                  placeholder: '${TKImages.image_path}animal_icon.png',
                ),
                SizedBox(width: 12.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('我叫' + model.petName, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.w900)),
                    SizedBox(height: 4.px),
                    Text('铲屎官记录我的生活', style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.w900)),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 8.px),
            child: Row(
              children: [
                Image.asset(TKImages.asset('card_left_pig'), width: 24, height: 20),
                SizedBox(width: 8.px),
                Expanded(
                  child: Container(
                    height: 160.px,
                    padding: EdgeInsets.symmetric(horizontal: 20.px),
                    decoration: BoxDecoration(
                      color: TKColor.white,
                      border: Border.all(color: TKColor.main_color, width: 2.px),
                      borderRadius: BorderRadius.circular(7.5.px)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: models.map((e) {
                        final index = models.indexOf(e) ?? 0;
                        final isLast = index == models.length - 1;
                        return Container(
                          height: (160.px - 6.px) / models.length,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: TKColor.main_color, width: isLast ? 0 : 1.px)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(TKImages.asset('record_icon'), width: 18.px, height: 18.px),
                              SizedBox(width: 10.px),
                              Text(e.name, style: TextStyle(fontSize: 11.px, color: TKColor.color_333333))
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 8.px),
                Image.asset(TKImages.asset('card_right_pig'), width: 24, height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderMiddleItem() {
    return Container(
      height: 103,
      padding: EdgeInsets.symmetric(horizontal: 8.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('铲屎行动力超过80%用户', style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.bold)),
              Text('扫码下载APP', style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.bold))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(TKImages.asset('qrcode_icon'), width: 60.px, height: 60.px),
              Text('麻花宠物', style: TextStyle(fontSize: 12.px, color: TKColor.color_999999))
            ],
          )
        ],
      ),
    );
  }

  Widget renderBottomItem(BuildContext context) {
    final images = ['share_wechat', 'share_cycle', 'share_qq', 'share_image'];
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: TKColor.white,
        borderRadius: BorderRadius.circular(5.px)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: images.map((e) {
          final index = images.indexOf(e) ?? 0;
          return GestureDetector(
            child: Image.asset(TKImages.asset(e), width: 30.px, height: 30.px),
            onTap: () {
              shareAction(context, index);
            },
          );
        }).toList(),
      ),
    );
  }

  void shareAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        
        break;

      case 1:
        
        break;

      case 2:
        
        break;

      case 3:
        TKMediaUtil.saveByteImage(context, imageGlobal);
        break;

      default:
        break;
    }
  }
}