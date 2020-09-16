import 'package:flutter/material.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';

import '../view_model/topic_http.dart';
import '../models/model_index.dart';
import 'answer_content.dart';



class AnswerPage extends StatefulWidget {
  final QuestionListModel model;
  final QuestionModel questionModel;
  AnswerPage({this.model, this.questionModel});

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {

  int _pageIndex = 1;
  bool _isLoading = false;
  AnswerModel _currentModel;
  AnswerModel _nextModel;

  PageController _pageController = PageController(keepPage: false);
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    loadAnswerData(isInit: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.questionModel.title)),
      body: Expanded(
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: [
            AnswerContent(),
            AnswerContent(),
            AnswerContent(),
          ],
          onPageChanged: (index) {
          },
        ),
      ),
    );
  }

  void loadAnswerData({bool isInit = false}) {
    if (!isInit) {
      TKToast.showLoading();
    }
    _isLoading = true;
    final _model = widget.model;
    final _questionModel = widget.questionModel;
    TopicHttp.requestAnswer(pageIndex: _pageIndex, answerId: _model.answerId, questionId: _questionModel.questionId)
      .then((value) {
        _isLoading = false;
        TKToast.dismiss();

        Map<String, AnswerModel> maps = value;
        _currentModel = maps['current'];
        _nextModel = maps['next'];

        setState(() { });
      }).catchError((error) {
        _isLoading = false;
        TKToast.dismiss();
        setState(() { });
      });
  }
}