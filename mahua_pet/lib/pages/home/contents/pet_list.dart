import 'package:mahua_pet/pages/home/contents/pet_add.dart';
import 'package:mahua_pet/pages/home/request/home_request.dart';
import 'package:mahua_pet/utils/route_util.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/redux/models/pet_model.dart';
import 'package:mahua_pet/pages/home/view_model/pet_view_model.dart';
import 'package:mahua_pet/styles/app_style.dart';


class PetListPage extends StatelessWidget {

  static const routeName = '/pet_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('宠物列表'),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Center(child: Text('添加', style: TextStyle(fontSize: 16.px, color: TKColor.color_1a1a1a))),
            onTap: () {
              TKRoute.push(context, PetAddPage(isAdd: true));
            },
          ),
          SizedBox(width: 8.px),
        ],
      ),
      body: PetListContent(),
    );
  }
}

class PetListContent extends StatefulWidget {

  @override
  _PetListContentState createState() => _PetListContentState();
}

class _PetListContentState extends State<PetListContent> {
  
  @override
  void initState() { 
    super.initState();

    HomeRequest.requestPetList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.px),
      child: Selector<PetViewModel, List<PetModel>>(
        selector: (ctx, petVM) => petVM.petList,
        shouldRebuild: (previous, next) => !listEquals(previous, next),
        builder: (ctx, petList, child) {
          return ListView.builder(
            itemCount: petList.length,
            itemBuilder: (ctx, i) {
              return renderPetItems(context, petList[i]);
            }
          );
        }, 
      ),
    );
  }

  Widget renderPetItems(BuildContext context, PetModel model) {
    return GestureDetector(
      child: Container(
        height: 200.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.px),
          image: DecorationImage(
            image: CachedNetworkImageProvider(model.backgroundUrl)
          )
        ),
        child: Center(
          child: Container(
            width: SizeFit.screenWidth - 86.px,
            height: 120.px,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4)
            ),
            child: Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Positioned(
                  top: -20.px,
                  child: TKNetworkImage(
                    imageUrl: model.petImg,
                    width: 40.px, height: 40.px,
                    boxRadius: 20.px,
                    fit: BoxFit.cover,
                    placeholder: '${TKImages.image_path}animal_icon.png',
                  ),
                ),
                Positioned(
                  top: 30.px,
                  child: Column(
                    children: <Widget>[
                      Text(model.petName, style: TextStyle(fontSize: 16.px, color: TKColor.color_333333)),
                      SizedBox(height: 10.px),
                      Text(
                        '${model.petBreed} | ${model.age} | ${model.petKg}KG', 
                        style: TextStyle(fontSize: 13.px, color: TKColor.color_666666)
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

