import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';

import 'package:mahua_pet/pages/home/contents/pet_add.dart';
import 'package:mahua_pet/pages/home/request/home_request.dart';



class PetListPage extends StatefulWidget {
  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {

  @override
  void initState() { 
    super.initState();

    HomeRequest.requestPetList(context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        final petList = store.state.petList ?? [];
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
          body: Container(
            padding: EdgeInsets.all(8.px),
            child: ListView.builder(
              itemCount: petList.length,
              itemBuilder: (ctx, i) {
                return renderPetItems(petList[i], store);
              }
            )
          ),
        );
      },
    );
  }

  Widget renderPetItems(PetModel model, Store store) {
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
      onTap: () {
        store.dispatch(UpdateCurrentPet(model));
        Navigator.of(context).pop();
      },
    );
  }
}

