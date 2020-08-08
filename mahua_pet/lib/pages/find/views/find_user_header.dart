import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../models/model_index.dart';

class FindUserHeaer extends StatelessWidget {

  final UserInfo _userInfo;
  final UserData _userData;

  final FindActionCallBack actionCallback;
  final FindHeaderCallback headerCallback;

  FindUserHeaer({UserData userData, this.actionCallback, this.headerCallback}): 
    _userData = userData ?? UserData(),
    _userInfo = userData == null ? UserInfo() : (userData.userinfo ?? UserInfo());

  @override
  Widget build(BuildContext context) {

    final isMine = _userData.followStatus == '自己';
    final isFollowed = _userData.followStatus == '关注';
    return Container(
      height: 300,
      child: Stack(
      children: <Widget>[
        Container(
          width: SizeFit.screenWidth,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(TKImages.image_path + 'home_back.png'), fit: BoxFit.cover)
          ),
        ),
        Positioned(
          top: 18.px + SizeFit.navHeight,
          child: Container(
            padding: EdgeInsets.only(left: 16.px, right: 16.px),
            child: Row(
              children: <Widget>[
                TKNetworkImage(
                  imageUrl: _userInfo.headImg ?? '',
                  width: 70.px, height: 70.px,
                  boxRadius: 40.px,
                  borderColor: TKColor.white,
                  borderWidth: 2.px,
                  placeholder: TKImages.user_header,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: animalInfoList(),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: SizeFit.navHeight,
          right: 16.px,
          child: GestureDetector(
            child: isMine ? Container() : Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
              decoration: BoxDecoration(
                color: TKColor.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                _userData.followStatus ?? '', 
                style: TextStyle(fontSize: 14.px, color: isFollowed ? TKColor.color_333333 : TKColor.color_cccccc, fontWeight: FontWeight.w500)
              ),
            ),
            onTap: () {
              actionCallback(FindActionType.attation);
            },
          ),
        ),
        Positioned(
          bottom: 20.px,
          left: 20.px,
          child: Container(
            width: SizeFit.screenWidth - 40.px,
            height: 70.px,
            decoration: BoxDecoration(
              color: TKColor.white,
              borderRadius: BorderRadius.circular(10.px),
              boxShadow: [
                BoxShadow(color: TKColor.color_b6b6b6, offset: Offset(-2, -2), blurRadius: 5.px),
                BoxShadow(color: TKColor.color_b6b6b6, offset: Offset(2, 2), blurRadius: 5.px),
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                renderNumberItem('获赞', '${_userData.agreeCount}', FindHeaderActionType.agreeList),
                renderNumberItem('粉丝', '${_userData.fansCount}', FindHeaderActionType.fansList),
                renderNumberItem('关注', '${_userData.followCount}', FindHeaderActionType.focusList),
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }

  List<Widget> animalInfoList() {

    List<Widget> lists = [];
    Text title = Text.rich(TextSpan(children: titleTexts(_userInfo.nickname ?? '', _userInfo.sex ?? '')));
    lists.add(title);

    lists.add(SizedBox(height: 2.px));

    final intro = (_userInfo.intro ?? '').length > 0 ? _userInfo.intro : '未设置个人签名';
    lists.add(Text(intro, style: TextStyle(fontSize: 14.px, color: TKColor.color_333333, height: 1.3)));
    return lists;
  }

  List<InlineSpan> titleTexts(String name, String sex) {
    List<InlineSpan> lists = [];
    WidgetSpan title = WidgetSpan(
      child: Text(
        name, 
        style: TextStyle(fontSize: 18.px, color: TKColor.color_333333, fontWeight: FontWeight.w600, height: 1.5)
      ),
      alignment: PlaceholderAlignment.middle
    );
    lists.add(title);
    if (sex.length > 0) {
      final imgIcon = sex == 'M' ? '${TKImages.image_path}animal_female.png' : '${TKImages.image_path}animal_male.png';
      WidgetSpan icon = WidgetSpan(
        child: Image.asset(imgIcon, width: 15.px, height: 15.px),
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle
      );
      lists.add(icon);
    }
      
    return lists;
  }

  Widget renderNumberItem(String name, String number, FindHeaderActionType type) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(number, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333, fontWeight: FontWeight.w700)),
          SizedBox(height: 4.px),
          Text(name, style: TextStyle(fontSize: 12.px, color: TKColor.color_333333)),
        ],
      ),
      onTap: () {
        headerCallback(type);
      },
    );
  }
}