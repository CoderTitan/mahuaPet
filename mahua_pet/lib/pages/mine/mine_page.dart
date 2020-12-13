
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';

import 'package:mahua_pet/flutter_widget/widget/widget_page.dart';
import './contents/setting_page.dart';



class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with NavigatorObserver {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        final isLogin = store.state.isLogin ?? false;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(S.of(context).mine_title,),
            centerTitle: true,
            actions: renderActionns(store),
          ),
          body: Container(
            color: TKColor.marginColor(store.state.isNightModal),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: () {
                if (!isLogin) {
                  _refreshController.refreshCompleted();
                  return;
                }
                FetchUserInfoAction.loadPetList(store);
                FetchUserInfoAction.loadUserData(store).then((value) {
                  _refreshController.refreshCompleted();
                }).catchError((e) {
                  _refreshController.refreshCompleted();
                });
              },
              child: CustomScrollView(
                slivers: [
                  renderHeaderItem(store),
                  renderMiddleInfo(store),
                  renderAnimalTitle(store),
                  renderAnimalList(store),
                  renderMineList(context, store)
                ],
              ),
            ),
          )
        );
      },
    );
  }

  List<Widget> renderActionns(Store store) {
    bool isLogin = store.state.isLogin ?? false;
    List<Widget> actions = [];

    Widget message = IconButton(icon: Icon(Icons.notifications_active), onPressed: () {
      _refreshController.refreshCompleted();
    });
    actions.add(message);

    Widget settinng = IconButton(icon: Icon(Icons.settings), onPressed: () {
      if (isLogin) {
        TKRoute.push(context, SettingPage());
      } else {
        FuncUtils.jumpLogin(context);
      }
    });
    actions.add(settinng);

    return actions;
  }

  Widget renderHeaderItem(Store store) {
    bool isLogin = store.state.isLogin ?? false;
    UserData userModel = store.state.userData ?? UserData();
    UserInfo userInfo = userModel.userinfo ?? UserInfo();
    String headerImg = isLogin ? userInfo.headImg ?? '' : '';
    String nickName = isLogin ? userInfo.nickname ?? '' : S.of(context).login_no;
    String userIntro = isLogin ? userInfo.intro ?? '' : '';
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: SizeFit.screenWidth,
            height: 110.px,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(store.state.themeData.primaryColor, BlendMode.srcOver),
              child: Image.asset(TKImages.asset('home_back'), fit: BoxFit.cover),
            ),
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(16.px, 16.px, 8.px, 16.px),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TKNetworkImage(
                          imageUrl: headerImg,
                          width: 70.px,
                          height: 70.px,
                          boxRadius: 40.px,
                          borderColor: Colors.white,
                          borderWidth: 2.px,
                        ),
                        SizedBox(width: 10.px),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nickName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.px, color: TKColor.white, fontWeight: FontWeight.bold)
                              ),
                              SizedBox(height: isLogin ? 3.px : 0),
                              isLogin ? Text(userIntro, maxLines: 2, style: TextStyle(fontSize: 13.px, color: TKColor.white)) : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, size: 30.px, color: TKColor.white)
                ],
              ),
            ),
            onTap: () {
              if (isLogin) {
                TKRoute.push(context, SettingPage());
              } else {
                FuncUtils.jumpLogin(context);
              }
            },
          )
        ],
      ),
    );
  }

  Widget renderMiddleInfo(Store store) {
    bool isLogin = store.state.isLogin ?? false;
    UserData userModel = store.state.userData ?? UserData();

    if (!isLogin) {
      return SliverToBoxAdapter(child: Container());
    }

    final titles = [S.of(context).mine_agree, S.of(context).mine_fans, S.of(context).mine_flower];
    final numbers = [userModel.agreeCount, userModel.fansCount, userModel.followCount];
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16.px),
        height: 100.px,
        decoration: BoxDecoration(
          color: TKColor.whiteColor(store.state.isNightModal),
          borderRadius: BorderRadius.circular(10.px),
          boxShadow: [
            BoxShadow(color: Colors.black12, offset: Offset(3.0, 3.0), blurRadius: 4.0),
            BoxShadow(color: Colors.black12, offset: Offset(-1.0, -1.0), blurRadius: 4.0)
          ] 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: titles.map((e) {
            final index = titles.indexOf(e);
            final number = numbers[index];
            return GestureDetector(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$number', style: TextStyle(fontSize: 20.px, color: TKColor.blackColor(store.state.isNightModal), fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.px),
                    Text(e, style: TextStyle(fontSize: 14.px, color: TKColor.blackColor(store.state.isNightModal))),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      )
    );
  }

  Widget renderAnimalTitle(Store store) {
    List<PetModel> petList = store.state.petList ?? [];
    if (petList.length == 0) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverToBoxAdapter(
      child: Container(
        width: SizeFit.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).mine_pet, style: TextStyle(fontSize: 15.px, color: TKColor.blackColor(store.state.isNightModal))),
            GestureDetector(
              child: Row(
                children: [
                  Text(S.of(context).mine_all, style: TextStyle(fontSize: 14.px, color: TKColor.grayColor(store.state.isNightModal))),
                  Icon(Icons.keyboard_arrow_right, color: TKColor.grayColor(store.state.isNightModal), size: 18.px)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderAnimalList(Store store) {
    List<PetModel> petList = store.state.petList ?? [];
    if (petList.length == 0) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(right: 15.px),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: petList.map((e) {
            return renderAnimalItem(store, e);
          }).toList(),
        ),
      ),
    );
  }

  Widget renderAnimalItem(Store store, PetModel petModel) {
    return Card(
      elevation: 0.px,
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 16.px, bottom: 8.px),
      child: Container(
        padding: EdgeInsets.all(10.px),
        decoration: BoxDecoration(
          color: TKColor.whiteColor(store.state.isNightModal),
          borderRadius: BorderRadius.circular(8.px)
        ),
        child: Row(
          children: [
            TKNetworkImage(
              imageUrl: petModel.petImg ?? '',
              width: 50.px, 
              height: 50.px,
              boxRadius: 40.px,
            ),
            SizedBox(width: 8.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petModel.petName ?? '', 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.px, color: TKColor.blackColor(store.state.isNightModal), fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 3.px),
                Text(petModel.age ?? '', maxLines: 2, style: TextStyle(fontSize: 13.px, color: TKColor.grayColor(store.state.isNightModal))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget renderMineList(BuildContext context, Store store) {
    final titles = [S.of(context).mine_theme, S.of(context).mine_local, 'Flutter Widget'];
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
          color: TKColor.whiteColor(store.state.isNightModal),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: titles.map((e) {
            final index = titles.indexOf(e);
            final isLast = index == titles.length - 1;
            return GestureDetector(
              child: Container(
                height: 56.px,
                padding: EdgeInsets.symmetric(horizontal: 8.px),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: TKColor.lineColor(store.state.isNightModal), width: isLast ? 0.001 : 1))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e, style: TextStyle(fontSize: 16.px, color: TKColor.blackColor(store.state.isNightModal))),
                    Icon(Icons.keyboard_arrow_right, color: TKColor.lineColor(store.state.isNightModal), size: 18.px),
                  ],
                ),
              ),
              onTap: () {
                if (index == 0) {
                  showThemeDialog(context, store);
                } else if (index == 1) {
                  showLocalDialog(context, store);
                } else {
                  TKRoute.push(context, WidgetPage());
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void showThemeDialog(BuildContext context, Store store) {
    final titles = [
      S.of(context).theme_0,
      S.of(context).theme_1,
      S.of(context).theme_2,
      S.of(context).theme_3,
      S.of(context).theme_4,
      S.of(context).theme_5,
      S.of(context).theme_6,
    ];
    final colors = TKCommonConfig.getThemeColors();
    TKActionAlert.showCommitOptionDialog(
      context: context,
      colorList: colors,
      titleList: titles,
      isNight: store.state.isNightModal,
      onTap: (index) {
        FuncUtils.setThemeData(store, index);
        SharedUtils.setInt(ShareConstant.themeColorIndex, index);
      }
    );
  }

  void showLocalDialog(BuildContext context, Store store) {
    final titles = ['中文', 'English', '한국어'];
    TKActionAlert.showCommitOptionDialog(
      context: context,
      titleList: titles,
      isNight: store.state.isNightModal,
      onTap: (index) {
        FuncUtils.changeLocale(store, index);
        SharedUtils.setInt(ShareConstant.localIndex, index);
      }
    );
  }
}

