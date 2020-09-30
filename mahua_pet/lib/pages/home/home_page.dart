
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/pages/home/contents/pet_add.dart';
import 'package:mahua_pet/pages/home/contents/pet_list.dart';
import 'package:mahua_pet/pages/home/view_model/home_view_model.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/pages/home/contents/calendar_page.dart';
import 'package:mahua_pet/redux/models/pet_model.dart';
import 'views/home_swiper.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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

    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            renderHeader(context, store),
            SliverToBoxAdapter(
              child: HomeSwiper(),
            ),
          ],
        );
      },
    );
  }

  Widget renderHeader(BuildContext context, Store store) {
    return SliverToBoxAdapter(
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
          IconButton(
            iconSize: 18.px,
            icon: Image.asset('${TKImages.image_path}calendar.png', color: TKColor.grayColor(store.state.isNightModal),), 
            onPressed: () {
              Navigator.of(context).pushNamed(CalendarPage.routeName);
            }
          ),
        ],
      ),
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
    final isLogin = store.state.isLogin ?? false;
    List petList = store.state.petList ?? [];
    final rightText = isLogin ? (petList.length > 0 ? '选择宠物' : '添加宠物') : '添加宠物';
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
                Text(rightText, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)),
                Icon(Icons.keyboard_arrow_right, size: 24, color: TKColor.color_1a1a1a)
              ],
            ),
          ),
        ),
        onTap: () => selectAnimal(context, store),
      )
    );
  }

  Widget initAnimalInfo(BuildContext context, Store store) {
    List<PetModel> petList = store.state.petList ?? []; 
    PetModel model = store.state.currentPet ?? petList.first;
    final isLogin = store.state.isLogin;
    final isPet = petList.length > 0;
    final animalIcon = isLogin ? (model != null ? (model.petImg ?? '') : '') : '';

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
              boxRadius: 40.px,
              showProgress: true,
              fit: BoxFit.cover,
              placeholder: '${TKImages.image_path}animal_icon.png',
            ),
            onTap: () => animalHeaderClick(context, isPet, model)
          ),
          SizedBox(width: 16.px),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: animalInfoList(store),
          )
        ],
      ),
    );
  }

  List<Widget> animalInfoList(Store store) {
    bool isNight = store.state.isNightModal;
    List<PetModel> petList = store.state.petList ?? []; 
    PetModel model = store.state.currentPet ?? petList.first;
    final isLogin = store.state.isLogin;
    final isPet = petList.length > 0;

    final animalName = isLogin ? (isPet ? model.petName : '未添加宠物') : '未登录';
    final animalBreed = isLogin ? (isPet ? model.petBreed : '') : '';
    final animalSex = isLogin ? (isPet ? model.sex : '') : '';
    final animalDay = isLogin ? (isPet ? '已${model.day}' : '') : '';
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
                width: 75.px,
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