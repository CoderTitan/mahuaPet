
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';

import '../view_model/view_model_index.dart';
import '../models/model_index.dart';
import '../views/find_item.dart';




class FindFocusPage extends StatefulWidget {
  @override
  _FindFocusPageState createState() => _FindFocusPageState();
}

class _FindFocusPageState extends State<FindFocusPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ConsumerProvider<FindFocusProvider>(
      model: FindFocusProvider(),
      onModelReady: (focusVM) {
        if (FuncUtils.isLogin()) {
          focusVM.initDatas();
        }
      },
      builder: (ctx, focusVM, child) {
        focusVM.setPostArray(focusVM.list);
        return SmartRefresher(
          controller: focusVM.refreshController,
          enablePullUp: FuncUtils.isLogin(),
          onRefresh: () async {
            if (FuncUtils.isLogin()) {
              focusVM.refreshData();
              focusVM.showErrorMessage(context);
            } else {
              focusVM.refreshController.refreshCompleted();
            }
          },
          onLoading: focusVM.loadMoreData,
          child: CustomScrollView(
            slivers: <Widget>[
              renderFocusContent(),
              renderPostList(focusVM)
            ],
          )
        );
      },
      // child: renderFocusContent(),
    );
  }

  Widget renderFocusContent() {
    return SliverToBoxAdapter(
      child: ConsumerProvider<FindRecomFocusProvider>(
        model: FindRecomFocusProvider(),
        onModelReady: (recomVM) {
          
          if (FuncUtils.isLogin()){
            recomVM.refreshData();
          }
        },
        builder: (_, recomVM, child) {
          return Column(
            children: <Widget>[
              renderFocusTitle(recomVM),
              renderFocusList(recomVM)
            ],
          );
        },
      ),
    );
  }

  Widget renderFocusTitle(FindRecomFocusProvider recomVM) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.px),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(S.of(context).find_know, style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)),
              SmallButton(title: S.of(context).find_change, onPressed: () {
                recomVM.refreshData();
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget renderFocusList(FindRecomFocusProvider recomVM) {
    return Container(
      color: TKColor.white,
      padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recomVM.list.map((item) => renderFocusItem(item, recomVM)).toList(),
        ),
      ),
    );
  }

  Widget renderFocusItem(FocusModel item, FindRecomFocusProvider recomVM) {
    final itemWidth = (SizeFit.screenWidth - (32 + 20).px) / 3;
    return Container(
      margin: EdgeInsets.only(right: 16.px),
      padding: EdgeInsets.all(10.px),
      constraints: BoxConstraints(minWidth: itemWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.px),
        border: Border.all(color: TKColor.color_e8e8e8, width: 0.5.px),
        color: TKColor.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TKNetworkImage(
            imageUrl: item.headImg,
            width: 50.px,
            height: 50.px,
            boxRadius: 30.px,
            placeholder: TKImages.image_path + 'user_header.png',
          ),
          SizedBox(height: 4.px),
          Container(
            height: 24.px, 
            child: Text(item.nickname, style: TextStyle(fontSize: 16.px, color: TKColor.color_333333))
          ),
          Container(
            height: 24.px, 
            child: Text(item.petBreed ?? '', style: TextStyle(fontSize: 13.px, color: TKColor.color_999999)),
          ),
          Container(
            height: 20.px, 
            child: Text(S.of(context).find_focus_count('${item.relationNum}'), style: TextStyle(fontSize: 10.px, color: TKColor.color_999999)),
          ),
          FocusButton(
            isSelect: item.isRelation ?? false,
            onPressed: () => recomVM.requestFocusState(item)
          )
        ],
      ),
    );
  }

  Widget renderPostList(FindFocusProvider focusVM) {
    if (focusVM.isBusy) {
      return SliverToBoxAdapter(
        child: EmptyContent(),
      );
    }

    final focusList = focusVM.postArray.length == 0 ? focusVM.list : focusVM.postArray;
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.px),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            final model = focusList[index];
            return FindListItem(model: model, key: ValueKey(index), actionCallback: (type) {
              focusVM.reloadList(model);
            });
          },
          childCount: focusList.length
        )
      ),
    );
  }
}