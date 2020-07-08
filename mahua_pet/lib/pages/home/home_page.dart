
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/home/contents/pet_add.dart';
import 'package:mahua_pet/pages/home/contents/pet_list.dart';
import 'package:mahua_pet/pages/home/request/home_request.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';

import 'package:mahua_pet/pages/home/contents/calendar_page.dart';
import 'package:mahua_pet/pages/home/models/pet_model.dart';
import './view_model/pet_view_model.dart';
import 'views/home_swiper.dart';
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
  void initState() {
    super.initState();

    if (FuncUtils.isLogin()) {
      HomeRequest.requestPetList(context);
      HomeRequest.requestHomeSwiper(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        renderHeader(context),
        SliverToBoxAdapter(
          child: HomeSwiper(),
        ),
        // HomeList()
      ],
    );
  }

  Widget renderHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 250.px + SizeFit.statusHeight,
            child: Stack(
              children: <Widget>[
                initBackImage(),
                initRightSelect(context),
                initAnimalInfo(context),
                initAnimalLifes(context)
              ],
            ),
          ),
          IconButton(
            iconSize: 18.px,
            icon: Image.asset('${TKImages.image_path}calendar.png'), 
            onPressed: () {
              Navigator.of(context).pushNamed(CalendarPage.routeName);
            }
          ),
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

  Widget initRightSelect(BuildContext context) {
    return Positioned(
      right: 15.px,
      top: 10.px + SizeFit.statusHeight,
      child: GestureDetector(
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
                Selector<PetViewModel, List<PetModel>>(
                  selector: (ctx, petVM) => petVM.petList,
                  shouldRebuild: (previous, next) => !listEquals(previous, next),
                  builder: (ctx, pets, child) {
                    String _selectTitle = pets.length > 0 ? '选择宠物' : '添加宠物';
                    return Text(_selectTitle, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333));
                  }, 
                ),
                Icon(Icons.keyboard_arrow_right, size: 24, color: TKColor.color_1a1a1a)
              ],
            ),
          ),
        ),
        onTap: () => selectAnimal(context),
      )
    );
  }

  Widget initAnimalInfo(BuildContext context) {
    return Consumer<PetViewModel>(builder: (ctx, petVM, chiild) {
      final model = petVM.currentModel;
      final isLogin = FuncUtils.isLogin();
      final isPet = petVM.petList.length > 0;
      final animalIcon = isLogin ? (isPet ? model.petImg : '') : '';

      return Positioned(
        left: 20.px,
        top: 90.px,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: TKNetworkImage(
                imageUrl: animalIcon,
                width: 70.px, height: 70.px,
                borderColor: Colors.white,
                borderWidth: 2,
                borderRadius: 35.px,
                showProgress: true,
                fit: BoxFit.cover,
                placeholder: '${TKImages.image_path}animal_icon.png',
              ),
              onTap: () => animalHeaderClick(context, isPet, model)
            ),
            SizedBox(width: 16.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: animalInfoList(model, isPet),
            )
          ],
        ),
      );
    });
  }

  List<Widget> animalInfoList(PetModel model, bool isPet) {
    final isLogin = FuncUtils.isLogin();
    final animalName = isLogin ? (isPet ? model.petName : '未添加宠物') : '未登录';
    final animalBreed = isLogin ? (isPet ? model.petBreed : '') : '';
    final animalSex = isLogin ? (isPet ? model.sex : '') : '';
    final animalDay = isLogin ? (isPet ? '已${model.day}' : '') : '';
    final animalAge = isLogin ? (isPet ? model.age : '') : '';
    final animalWeight = isLogin ? (isPet ? model.petKg : '') : '';
    final animalInfo = animalAge.length > 0 || animalBreed.length > 0 || animalWeight.length > 0 ? '$animalAge|$animalBreed|${animalWeight}KG' : '';

    List<Widget> lists = [];
    Text title = Text.rich(TextSpan(children: titleTexts(animalName, animalSex)));
    lists.add(title);
    if (animalDay.length > 0) {
      lists.add(SizedBox(height: 2.px));
      lists.add(Text(animalDay, style: TextStyle(fontSize: 13.px, color: TKColor.color_333333, height: 1.3)));
    }
    if (animalInfo.length > 0) {
      lists.add(Text(animalInfo, style: TextStyle(fontSize: 13.px, color: TKColor.color_333333, height: 1.3)));
    }
    return lists;
  }

  List<InlineSpan> titleTexts(String name, String sex) {
    List<InlineSpan> lists = [];
    WidgetSpan title = WidgetSpan(
      child: Text(
        name, 
        style: TextStyle(fontSize: 18.px, color: TKColor.color_333333, fontWeight: FontWeight.w600, height: 1.3)
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

  Widget initAnimalLifes(BuildContext context) {
    final titles = ['日常打卡', '提醒吧', '健康管理', '体重记录', '相册'];
    final images = ['home_record.png', 'home_warn.png', 'home_fit.png', 'home_weight.png', 'home_album.png'];
    return Positioned(
      bottom: 0,
      left: 15.px,
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        height: 100.px,
        padding: EdgeInsets.symmetric(horizontal: 10.px),
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
              onTap: () => scrollItemClick(context, index)
            );
          }
        ),
      ),
    );
  }

  void selectAnimal(BuildContext context) {
    final isLogin = FuncUtils.isLogin();
    if (!isLogin) {
      FuncUtils.jumpLogin(context);
      return;
    }

    PetViewModel petVM = Provider.of<PetViewModel>(context, listen: false);

    if (petVM.petList.length > 0) {
      Navigator.of(context).pushNamed(PetListPage.routeName);
    } else {
      TKRoute.push(context, PetAddPage(isAdd: true, model: null));
    }
  }

  void animalHeaderClick(BuildContext context, bool isPet, PetModel model) {
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