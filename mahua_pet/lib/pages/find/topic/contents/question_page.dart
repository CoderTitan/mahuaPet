import 'package:flutter/material.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../models/model_index.dart';
import 'question_list.dart';

class QuestionPage extends StatefulWidget {

  final QuestionModel model;

  QuestionPage({this.model});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with SingleTickerProviderStateMixin {

  List<String> tabs = ['热门', '最新'];
  TabController _tabController ;

  @override
  void initState() { 
    super.initState();
    
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (ctx, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: renderHeaderItem(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                isNight: false,
                child: TabBar(
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                  isScrollable: false,
                  indicatorColor: TKColor.main_color,
                  indicatorWeight: 2.px,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: TKColor.main_color,
                  unselectedLabelColor: TKColor.color_666666,
                  labelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold),
                  labelPadding: EdgeInsets.symmetric(horizontal: 20.px),
                )
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return QuestionList(
              key: ValueKey(e), 
              isHot: e == '热门',
              model: widget.model,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget renderHeaderItem() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: TKColor.white,
        border: Border(bottom: BorderSide(color: TKColor.color_f7f7f7, width: 12))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.model.title}', style: TextStyle(fontSize: 18.px, color: TKColor.color_1a1a1a, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.px),
          Row(
            children: [
              Text.rich(TextSpan(
                text: '回答: ',
                style: TextStyle(fontSize: 12.px, color: TKColor.color_999999),
                children: [TextSpan(
                  text: '${widget.model.answerNum}', 
                  style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)
                )]
              )),
              SizedBox(width: 16.px),
              Text.rich(TextSpan(
                text: '阅读: ',
                style: TextStyle(fontSize: 12.px, color: TKColor.color_999999),
                children: [TextSpan(
                  text: '${widget.model.questionReadNum}', 
                  style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)
                )]
              )),
              SizedBox(width: 16.px),
              Text.rich(TextSpan(
                text: '讨论: ',
                style: TextStyle(fontSize: 12.px, color: TKColor.color_999999),
                children: [TextSpan(
                  text: '${widget.model.commentNum}', 
                  style: TextStyle(fontSize: 14.px, color: TKColor.color_333333)
                )]
              )),
            ],
          )
        ],
      ),
    );
  }
}