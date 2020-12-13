import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../view_model/topic_http.dart';
import '../models/model_index.dart';
import '../../views/question_item.dart';
import '../../topic/contents/question_page.dart';


class HotTopicDetail extends StatefulWidget {

  final BreedModel model;
  final void Function(BreedModel) callBack;
  HotTopicDetail({this.model, this.callBack});

  @override
  _HotTopicDetailState createState() => _HotTopicDetailState();
}

class _HotTopicDetailState extends State<HotTopicDetail> {

  int _postPage = 1;
  bool _showLoading = true;
  bool _headerLoading = true;
  List<QuestionModel> _dataList = [];
  BreedModel _breedModel = BreedModel();
  int _totalCount = 0;
  int _orderType = 1;
  

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.model.tribeName)
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: renderContainView(),
        ),
      ),
    );
  }

  List<Widget> renderContainView() {
    List<Widget> lists = [];

    Widget header = SliverToBoxAdapter(child: renderHeaderItem());
    lists.add(header);

    if (_dataList.length > 0) {
      Widget section = SliverPersistentHeader(
        pinned: true,
        delegate: StickyChildDelegate(
          maxHeight: 44.px,
          minHeight: 44.px,
          child: renderTitleItem()
        )
      );
      lists.add(section);
      lists.add(renderPullList());
    } else {
      lists.add(SliverToBoxAdapter(child: EmptyContent()));
    }

    if (_headerLoading && _showLoading) {
      return [
        SliverFillRemaining(
          child: Center(child: RefreshProgressIndicator(strokeWidth: 3.px)),
        )
      ];
    } 

    return lists;
  }

  Widget renderHeaderItem() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(TKImages.image_path + 'home_back.png'), fit: BoxFit.cover),
        // color: TKColor.main_color
      ),
      child: Row(
        children: [
          TKNetworkImage(
            width: 110.px, 
            height: 110.px,
            boxRadius: 4.px,
            imageUrl: _breedModel.headImg ?? ''
          ),
          Expanded(
            child: Container(
              height: 100.px,
              margin: EdgeInsets.only(left: 14.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _breedModel.tribeName ?? '', 
                        style: TextStyle(fontSize: 18.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 4.px),
                      Text(
                        '犬种:${_breedModel.dogBreed ?? ''}', 
                        style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: TKColor.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 2.px),
                          child: Text(_breedModel.joinStatus == '0' ? '未关注' : '已关注', style: TextStyle(fontSize: 12.px, color: TKColor.color_1a1a1a)),
                        ),
                        onTap: () {
                          requestFollow();
                        },
                      ),
                      SizedBox(width: 4.px),
                      Text('${_breedModel.tribeUserCount}人关注', style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderTitleItem() {
    return Container(
      width: SizeFit.screenWidth,
      height: 44.px,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      decoration: BoxDecoration(
        color: TKColor.color_f7f7f7,
        border: Border(bottom: BorderSide(color: TKColor.color_e8e8e8, width: 1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$_totalCount个讨论', style: TextStyle(fontSize: 18.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.bold)),
          Builder(
            builder: (ctx) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      _orderType == 1 ? '热门' : '全部问题', 
                      style: TextStyle(fontSize: 14.px, color: TKColor.color_666666)
                    ),
                    onSelected: (text) {
                      TKToast.showLoading();
                      _orderType = text == '热门' ? 1 : 2;
                      _onRefresh();
                    },
                    itemBuilder: (ctx) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: '热门',
                          height: 30.px,
                          child: Text('热门', style: TextStyle(fontSize: 14.px)),
                        ),
                        PopupMenuItem(
                          value: '全部问题',
                          height: 30.px,
                          child: Text('全部问题', style: TextStyle(fontSize: 14.px)),
                        )
                      ];
                    }
                  ),
                  SizedBox(width: 4.px),
                  Icon(Icons.sort, size: 18.px, color: TKColor.color_666666)
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget renderPullList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            QuestionModel model = _dataList[index];
            return GestureDetector(
              child: QuestionItem(key: ValueKey(index), model: model),
              onTap: () {
                TKRoute.push(context, QuestionPage(model: model));
              },
            );
          },
          childCount: _dataList.length,
        ),
      ),
    );
  }

  void _onRefresh () {
    _postPage = 1;
    requestDataList(1);
    requestTribeInfo();
  }

  void _onLoading () {
    TKToast.showLoading();
    _postPage += 1;
    requestDataList(_postPage);
  }

  void requestTribeInfo() {
    TopicHttp.loadTribeInfo(widget.model.tribeId).then((value) {
      _breedModel = value;
      _headerLoading = false;
      widget.callBack(_breedModel);
      setState(() {});
    }).catchError((error) {
      _headerLoading = false;
      setState(() {});
    });
  }

  void requestDataList(pageIndex) {
    TopicHttp.loadQuestionList(pageIndex: pageIndex, tribeId: widget.model.tribeId, orderType: _orderType).then((value) {
      TKToast.dismiss();
      _showLoading = false;

      Map<String, dynamic> datas = value;
      List<QuestionModel> models = datas['models'];
      if (pageIndex == 1) {
        _dataList = models;
        _totalCount = datas['count'];
        _refreshController.refreshCompleted();
      } else {
        _dataList.addAll(models);
      }

      if (models.length >= 10) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
      setState(() {});
    }).catchError((error) {
      TKToast.dismiss();
      _showLoading = false;
      setState(() {});
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      print(error);
    });
  }

  void requestFollow() {
    TKToast.showLoading();
    TopicHttp.requestFocus(_breedModel.joinStatus, _breedModel.tribeId).then((value) {
      TKToast.dismiss();
      requestTribeInfo();
    }).catchError((error) {
      TKToast.dismiss();
    });
  }
}