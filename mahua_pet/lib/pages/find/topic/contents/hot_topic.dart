
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import '../view_model/topic_http.dart';
import '../models/model_index.dart';
import 'hot_topic_detail.dart';

class HotTopic extends StatefulWidget {
  @override
  _HotTopicState createState() => _HotTopicState();
}

class _HotTopicState extends State<HotTopic> {

  List<BreedModel> _dataList = [];
  int _postPage = 1;
  bool _showLoading = true;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('热门话题')),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: renderListView(),
      ),
    );
  }

  Widget renderListView() {
    if (_showLoading) {
      return Center(
        child: RefreshProgressIndicator(
          strokeWidth: 3.px,
        ),
      );
    }
    return ListView.builder(
      itemCount: _dataList.length,
      itemBuilder: (ctx, index) {
        return renderListItem(index);
      }
    );
  }

  Widget renderListItem(int index) {
    final model = _dataList[index];
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16.px),
        width: SizeFit.screenWidth,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: TKColor.color_e8e8e8, width: 0.5))
        ),
        child: Row(
          children: [
            TKNetworkImage(
              width: 100.px, 
              height: 100.px,
              boxRadius: 4.px,
              imageUrl: model.headImg
            ),
            Expanded(
              child: Container(
                height: 90.px,
                margin: EdgeInsets.only(left: 16.px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.tribeName, 
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis, 
                          style: TextStyle(fontSize: 16.px, color: TKColor.color_333333)
                        ),
                        SizedBox(height: 4.px),
                        Text(
                          model.tribeDescription ?? '', 
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis, 
                          style: TextStyle(fontSize: 15.px, color: TKColor.color_666666)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 18.px, color: TKColor.color_999999),
                        SizedBox(width: 4.px),
                        Text('${model.tribeUserCount}人关注', style: TextStyle(fontSize: 13.px, color: TKColor.color_999999)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        TKRoute.push(context, HotTopicDetail(model: model, callBack: (model) {
          _dataList.map((e) {
            if (e.tribeId == model.tribeId) {
              e.tribeUserCount = model.tribeUserCount;
            }
          }).toList();
          setState(() { });
        }));
      },
    );
  }

  void _onRefresh () {
    _postPage = 1;
    requestDataList(1);
  }

  void _onLoading () {
    _postPage += 1;
    TKToast.showLoading();
    requestDataList(_postPage);
  }

  void requestDataList(pageIndex) {
    TopicHttp.loadTopicList(pageIndex).then((value) {
      TKToast.dismiss();
      _showLoading = false;
      if (pageIndex == 1) {
        _dataList = value;
        _refreshController.refreshCompleted();
        if (value.length >= 10) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        _dataList.addAll(value);
        if (value.length >= 10) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      }
      setState(() {});
    }).catchError((error) {
      TKToast.dismiss();
      _showLoading = false;
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      print(error);
      setState(() {});
    });
  }

}