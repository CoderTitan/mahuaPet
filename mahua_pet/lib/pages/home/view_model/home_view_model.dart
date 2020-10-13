
import 'package:flutter/material.dart';
import '../models/swiper_model.dart';

class HomeViewModel extends ChangeNotifier {

  List<SwiperModel> _swiperArray = [];
  int _counter = 0;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  int get counter {
    return _counter;
  }
  

  set swiperArray(List<SwiperModel> value) {
    _swiperArray = value;
    notifyListeners();
  }

  List<SwiperModel> get swiperArray {
    return _swiperArray;
  }

  HomeViewModel() {
    counter = counter + 1;
  }
}





/// 成长管理
/// 这一年有多少记录
/// https://gate.ieasydog.com/api/user/growManager/selectGrowManagerList?petId=19985&year=2020
/// 某一天的记录
/// https://gate.ieasydog.com/api/user/growManager/selectGrowManagerList?day=10&month=10&petId=19985&year=2020
/// 医疗记录
/// https://gate.ieasydog.com/api/user/diseaseRecords/selectRecordsListByManagerId?growManagerId=25010&pageIndex=1&pageSize=10
/// 添加医疗记录, 
/// https://gate.ieasydog.com/api/user/diseaseRecords/save
/*
{
	"userId": 136899,
	"symptom": "哈哈",
	"fileIds": "67111",
	"diagnosticResult": "刚回家",
	"day": "10",
	"month": "10",
	"growManagerId": 25010,
	"year": "2020",
	"desc": "回家看看看"
}
*/

