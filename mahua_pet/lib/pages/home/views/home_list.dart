import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';

class HomeList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return renderHomeItem(index);
        },
        childCount: 10,
      )
    );
  }

  Widget renderHomeItem(index) {
    return Container(
      padding: EdgeInsets.all(8.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('5月', style: TextStyle(fontSize: 13.px, color: TKColor.color_999999, fontWeight: FontWeight.w500)),
              Text('25', style: TextStyle(fontSize: 17.px, color: TKColor.color_333333, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(width: 7.px),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 6.px,
                height: 6.px,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: TKColor.main_color, width: 2.px),
                  borderRadius: BorderRadius.all(Radius.circular(3.px))
                ),
              ),
              Container(
                child: DashedLine(
                  axis: Axis.vertical,
                  dashedHeight: 1.px,
                  count: 10,
                  color: TKColor.color_dedede,
                ),
              )
            ],
          ),
          SizedBox(width: 15.px),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.px)),
                boxShadow: [
                  BoxShadow(color: TKColor.color_e5e5e5, blurRadius: 5.px),
                  BoxShadow(color: TKColor.color_e5e5e5, blurRadius: 5.px),
                ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    renderChildTitleItem('日常打卡'),
                    renderChildItem(index)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderChildItem(index) {
    if (index == 0) {
      return renderRecordItem();
    } else if (index == 1) {
      return renderWeightItem();
    } else if (index == 2) {
      return renderAlbumItem();
    } else if (index == 3) {
      return renderFitnessItem();
    }
    return Container();
  }

  Widget renderChildTitleItem(String title) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.w600)),
              Text('12:09', style: TextStyle(fontSize: 12.px, color: TKColor.color_999999)),
            ],
          ),
          SizedBox(height: 10.px),
          Divider(height: 1, color: TKColor.color_e8e8e8),
        ],
      ),
    );
  }

  Widget renderRecordItem() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          renderRecordList()
        ],
      ),
    );
  }

  Widget renderRecordList() {
    return Container();
  }

  Widget renderWeightItem() {
    return Padding(
      padding: EdgeInsets.only(top: 12.px, bottom: 5.px),
      child: Text('球球新体重7KG，比上次重了0.8KG', style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
    );
  }

  Widget renderAlbumItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 8.px),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.px),
          child: FadeInImage(
            placeholder: AssetImage('${TKImages.image_path}home_back.png'), 
            image: NetworkImage('https://titanjun.oss-cn-hangzhou.aliyuncs.com/flutter/flutter_container.png', )
          ),
        ),
        SizedBox(height: 8.px),
        Text.rich(TextSpan(
          text: '球球新体重7KG，比上次重了0.8KG, 球球新体重7KG，比上次重了0.8KG',
          style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
        )),
      ],
    );
  }

  Widget renderFitnessItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 8.px),
        Text.rich(TextSpan(
          text: '医院：${'派特宠物医院'}',
          style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
        )),
        SizedBox(height: 4.px),
        Text.rich(TextSpan(
          text: '诊断结果：${'肠胃炎'}',
          style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
        )),
        SizedBox(height: 4.px),
        Text.rich(TextSpan(
          text: '病情描述：${'一直呕吐，拉稀'}',
          style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
        )),
        Wrap(
          spacing: 2.px,
          runSpacing: 10.px,
          children: renderFitnessImages(),
        )
      ],
    );
  }

  List<Widget> renderFitnessImages() {
    final image = '${TKImages.image_path}animal_icon.png';
    List<Widget> imageList = [];
    for (var i in [1, 2, 3, 4, 5]) {
      final assetImg = Image.asset(image, width: 70.px, height: 70.px);
      imageList.add(assetImg);
    }
    return imageList;
  }
}