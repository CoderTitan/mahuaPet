
import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/topic/contents/hot_topic.dart';
import 'package:mahua_pet/pages/find/views/hot_topic_item.dart';
import 'package:mahua_pet/pages/find/views/question_item.dart';
import 'package:mahua_pet/pages/find/views/skele_topic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import '../view_model/topic_page_provide.dart';
import '../models/model_index.dart';
import '../topic/contents/question_page.dart';

class FindTopicPage extends StatefulWidget {
  @override
  _FindTopicPageState createState() => _FindTopicPageState();
}

class _FindTopicPageState extends State<FindTopicPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ConsumerProvider<TopicPageProvider>(
      model: TopicPageProvider(),
      onModelReady: (topicModel) {
        if (FuncUtils.isLogin()) {
          topicModel.initDatas();
        }
      },
      builder: (ctx, topicVM, child) {
        return Container(
          color: TKColor.white,
          child: SmartRefresher(
            controller: topicVM.refreshController,
            enablePullUp: FuncUtils.isLogin(),
            onRefresh: () async {
              if (FuncUtils.isLogin()) {
                await topicVM.refreshData();
                topicVM.showErrorMessage(context);
              } else {
                topicVM.refreshController.refreshCompleted();
              }
            },
            onLoading: topicVM.loadMoreData,
            child: CustomScrollView(
              slivers: renderLists(topicVM),
            ),
          ),
        );
      },
    );
  }

  List<Widget> renderLists(TopicPageProvider topicVM) {
    List<Widget> items = [];
    if (topicVM.topicArray.length > 0) {
      items.add(renderTopicItems(topicVM));
    }
    if (topicVM.isEmpty) {
      Widget empty = SliverToBoxAdapter(
        child: EmptyContent(),
      );
      items.add(empty);
    } else {
      if (topicVM.isIdle) {
        items.add(renderListTitle());
      }
      items.add(renderPullList(topicVM));
    }

    return items;
  }

  Widget renderTopicItems(TopicPageProvider topicVM) {
    final topicArr = topicVM.topicArray;
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.px),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 16.px, top: 8.px, right: 4.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(S.of(context).find_hot_topic, style: TextStyle(fontSize: 16.px, color: TKColor.color_333333, fontWeight: FontWeight.bold)),
                    Row(
                      children: <Widget>[
                        Text(S.of(context).find_more, style: TextStyle(fontSize: 13.px, color: TKColor.color_666666)),
                        Icon(Icons.keyboard_arrow_right, color: TKColor.color_999999)
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {
                TKRoute.push(context, HotTopic());
              },
            ),
            SizedBox(height: 8.px),
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 16.px, right: 4.px),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: topicArr.map((e) {
                  return HotTopicItem(key: ValueKey(e), model: e);
                }).toList(),
              ),
            ),
            SizedBox(height: 20.px),
            Container(height: 12.px, color: TKColor.color_f7f7f7)
          ],
        ),
      ),
    );
  }

  Widget renderListTitle() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
        child: Text(S.of(context).find_hot_talk, style: TextStyle(fontSize: 20.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget renderPullList(TopicPageProvider topicVM) {
    Widget skeleton = SliverToBoxAdapter(
      child: SkeletonList(
        builder: (ctx, index) => SkeleTopicView(),
      ),
    );

    Widget sliverList = SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          QuestionModel model = topicVM.list[index];
          return GestureDetector(
            child: QuestionItem(key: ValueKey(index), model: model),
            onTap: () {
              TKRoute.push(context, QuestionPage(model: model));
            },
          );
        },
        childCount: topicVM.list.length,
      ),
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      sliver: topicVM.isBusy ? skeleton : sliverList,
    );
  }

}