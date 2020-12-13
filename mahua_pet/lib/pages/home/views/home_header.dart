import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';

import '../contents/pet_add.dart';
import '../contents/pet_list.dart';


class HomeHeader extends StatelessWidget {

  final bool scrollTop;
  final double flexHeaderHeight = 210.px + SizeFit.statusHeight;

  HomeHeader({this.scrollTop});


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return SliverAppBar(
          pinned: true,
          expandedHeight: flexHeaderHeight,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: TKColor.backColor(store.state.isNightModal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 250.px + SizeFit.statusHeight,
                    child: Stack(
                      children: <Widget>[
                        initBackImage(store),
                        initRightSelect(context, store),
                        initAnimalInfo(context, store),
                        initAnimalLifes(context, store)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            EmptyAnimatedSwitcher(
              child: renderRightItem(context, store),
              display: scrollTop,
            ),
            SizedBox(width: 8.px),
          ],
          leading: EmptyAnimatedSwitcher(
            display: scrollTop,
            child: GestureDetector(
              child: renderAnimalHeader(context, store, 40.px),
            ),
          ),
        );
      }
    );
  }

  Widget initBackImage(Store store) {
    return Container(
      width: SizeFit.screenWidth,
      height: 200.px + SizeFit.statusHeight,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(store.state.themeData.primaryColor, BlendMode.srcOver),
        child: Image.asset(TKImages.asset('home_back'), fit: BoxFit.fill),
      ),
    );
  }

  Widget initRightSelect(BuildContext context, Store store) {
    return Positioned(
      right: 15.px,
      top: 10.px + SizeFit.statusHeight,
      child: renderRightItem(context, store)
    );
  }

  Widget initAnimalInfo(BuildContext context, Store store) {
    return Positioned(
      left: 20.px,
      top: 90.px,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          renderAnimalHeader(context, store, 70.px),
          SizedBox(width: 16.px),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: animalInfoList(context, store),
          )
        ],
      ),
    );
  }

  Widget renderRightItem(BuildContext context, Store store) {
    final isLogin = store.state.isLogin ?? false;
    List petList = store.state.petList ?? [];
    final rightText = isLogin ? (petList.length > 0 ? S.of(context).pet_select : S.of(context).pet_add) : S.of(context).pet_add;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.px))
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.px, 6.px, 4.px, 6.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(rightText, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)),
              Icon(Icons.keyboard_arrow_right, size: 24, color: TKColor.color_1a1a1a)
            ],
          ),
        ),
      ),
      onTap: () => selectAnimal(context, store),
    );
  }

  Widget renderAnimalHeader(BuildContext context, Store store, double size) {
    List<PetModel> petList = store.state.petList ?? []; 
    PetModel model = store.state.currentPet ?? (petList.length > 0 ? petList.first : null);

    final isLogin = store.state.isLogin;
    final animalIcon = isLogin ? (model != null ? (model.petImg ?? '') : '') : '';

    return GestureDetector(
      child: TKNetworkImage(
        imageUrl: animalIcon,
        width: size, height: size,
        borderColor: Colors.white,
        borderWidth: 2,
        boxRadius: size / 2,
        showProgress: true,
        fit: BoxFit.cover,
        placeholder: '${TKImages.image_path}animal_icon.png',
      ),
      onTap: () => animalHeaderClick(context, model)
    );
  }

  List<Widget> animalInfoList(BuildContext context, Store store) {
    bool isNight = store.state.isNightModal;
    List<PetModel> petList = store.state.petList ?? []; 
    PetModel model = store.state.currentPet ?? (petList.length > 0 ? petList.first : null);
    final isLogin = store.state.isLogin;
    final isPet = petList.length > 0;

    final animalName = isLogin ? (isPet ? model.petName : S.of(context).pet_add_no) : S.of(context).login_no;
    final animalBreed = isLogin ? (isPet ? model.petBreed : '') : '';
    final animalSex = isLogin ? (isPet ? model.sex : '') : '';
    final animalDay = isLogin ? (isPet ? '${model.day}' : '') : '';
    final animalAge = isLogin ? (isPet ? model.age : '') : '';
    final animalWeight = isLogin ? (isPet ? model.petKg : '') : '';
    final animalInfo = animalAge.length > 0 || animalBreed.length > 0 || animalWeight.length > 0 ? '$animalAge|$animalBreed|${animalWeight}KG' : '';

    List<Widget> lists = [];
    Text title = Text.rich(TextSpan(children: titleTexts(animalName, animalSex, isNight)));
    lists.add(title);
    if (animalDay.length > 0) {
      lists.add(SizedBox(height: 2.px));
      lists.add(Text(animalDay, style: TextStyle(fontSize: 13.px, color: TKColor.blackColor(isNight), height: 1.3)));
    }
    if (animalInfo.length > 0) {
      lists.add(Text(animalInfo, style: TextStyle(fontSize: 13.px, color: TKColor.blackColor(isNight), height: 1.3)));
    }
    return lists;
  }

  List<InlineSpan> titleTexts(String name, String sex, bool isNight) {
    List<InlineSpan> lists = [];
    WidgetSpan title = WidgetSpan(
      child: Text(
        name, 
        style: TextStyle(fontSize: 18.px, color: TKColor.blackColor(isNight), fontWeight: FontWeight.w600, height: 1.3)
      ),
      alignment: PlaceholderAlignment.middle
    );
    lists.add(title);
    if (sex.length > 0) {
      final imgIcon = sex == '0' ? '${TKImages.image_path}animal_female.png' : '${TKImages.image_path}animal_male.png';
      WidgetSpan icon = WidgetSpan(
        child: Image.asset(imgIcon, width: 15.px, height: 15.px),
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle
      );
      lists.add(icon);
    }
      
    return lists;
  }

  Widget initAnimalLifes(BuildContext context, Store store) {
    bool isNight = store.state.isNightModal;

    final titles = [S.of(context).home_card, S.of(context).home_fit, S.of(context).home_weight, S.of(context).home_help, S.of(context).home_guide];
    final images = ['home_record.png', 'home_fit.png', 'home_weight.png', 'home_album.png', 'home_warn.png'];
    return Positioned(
      bottom: 0,
      left: 15.px,
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 100.px,
        padding: EdgeInsets.symmetric(horizontal: 10.px),
        decoration: BoxDecoration(
          color: TKColor.whiteColor(isNight),
          borderRadius: BorderRadius.all(Radius.circular(12.px)),
          boxShadow: [
            BoxShadow(color: TKColor.marginColor(isNight), offset: Offset(-2, -2), blurRadius: 5.px),
            BoxShadow(color: TKColor.marginColor(isNight), offset: Offset(2, 2), blurRadius: 5.px),
          ]
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: titles.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('${TKImages.image_path}${images[index]}', width: 38.px, height: 38.px, fit: BoxFit.contain),
                    SizedBox(height: 8.px),
                    Text(titles[index], style: TextStyle(fontSize: 13.px, color: TKColor.blackColor(isNight))),
                  ],
                ),
              ),
              onTap: () => scrollItemClick(context, index)
            );
          }
        ),
      ),
    );
  }

  void selectAnimal(BuildContext context, Store store) {
    List<PetModel> petList = store.state.petList ?? []; 
    final isLogin = store.state.isLogin;

    if (!isLogin) {
      FuncUtils.jumpLogin(context);
      return;
    }

    if (petList.length > 0) {
      TKRoute.push(context, PetListPage());
    } else {
      TKRoute.push(context, PetAddPage(isAdd: true, model: null));
    }
  }

  void animalHeaderClick(BuildContext context, PetModel model) {
    final isLogin = FuncUtils.isLogin();
    if (!isLogin) {
      FuncUtils.jumpLogin(context);
      return;
    }
    
    Widget pet = PetAddPage(isAdd: false, model: model);
    TKRoute.push(context, pet);
  }

  void scrollItemClick(BuildContext context, int index) {
    final isLogin = FuncUtils.isLogin();
    if (!isLogin) {
      FuncUtils.jumpLogin(context);
      return;
    }
    TKToast.showSuccess('已经登录了');
  }
}