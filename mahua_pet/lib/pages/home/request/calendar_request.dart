import 'package:flutter/cupertino.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/find/models/model_index.dart';
import 'package:mahua_pet/pages/find/view_model/view_model_index.dart';
import 'package:mahua_pet/pages/home/models/model_index.dart';
import 'package:mahua_pet/pages/home/view_model/view_model_index.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:provider/provider.dart';
import '../../../redux/models/pet_model.dart';
import '../models/model_index.dart';

class CalendarRequest {
  
  /// 获取日历所有记录
  static Future loadCalendarRecord(int petId, int year) async {
    final url = '${HttpConfig.selectGrowManagerList}?petId=$petId&year=$year';
    ResponseData result = await TKRequest.requestData(url);

    List<CalendarRecordModel> models = [];
    if (result.isSuccess) {
      List<dynamic> maps = result.data ?? [];
      models = maps.map((e) => CalendarRecordModel.fromJson(e)).toList();
    } else {
      TKToast.showError(result.message);
    }
    return models;
  }

  /// 当天的所有记录
  static Future loadCurrentRecords(int growId) async {
    final url = '${HttpConfig.selectManagerDetailByGrowManagerId}?growManagerId=$growId';
    ResponseData result = await TKRequest.requestData(url);

    List<RecordListModel> recordList = [];
    if (result.isSuccess) {
      List<dynamic> maps = result.data ?? [];
      recordList = maps.map((e) => RecordListModel.fromJson(e)).toList();
    } else {
      TKToast.showError(result.message);
    }
    return recordList;
  }

  /// 当天的记录Id
  static Future loadCurrentDayRecord({int petId, int year, int month, int day}) async {
    final monthStr = month < 10 ? '0$month' : '$month';
    final dayStr = day < 10 ? '0$day' : '$day';
    final url = '${HttpConfig.selectGrowManagerList}?petId=$petId&year=$year&month=$monthStr&day=$dayStr';
    ResponseData result = await TKRequest.requestData(url);

    List<RecordListModel> recordList = [];
    List<CalendarFitModel> fitList = [];
    List<dynamic> modelList = [recordList, fitList];
    if (result.isSuccess) {
      List<dynamic> maps = result.data ?? [];
      List<CalendarRecordModel> models = maps.map((e) => CalendarRecordModel.fromJson(e)).toList();
      if (models.length > 0) {
        recordList = await loadCurrentRecords(models.first.growManagerId);
        fitList = await loadFitnessList(models.first.growManagerId, 1);
        modelList = [recordList, fitList];
      }
    } else {
      TKToast.showError(result.message);
    }
    return modelList;
  }

  /// 当天的所有记录
  static Future loadFitnessList(int growManagerId, int pageIndex) async {
    final url = '${HttpConfig.selectRecordsListByManagerId}?growManagerId=$growManagerId&year=$pageIndex&pageSize=10';
    ResponseData result = await TKRequest.requestData(url);

    List<CalendarFitModel> recordList = [];
    if (result.isSuccess) {
      if (result.data != null && result.data['records'] != null) {
        List<dynamic> jsonArr = result.data['records'] ?? [];
        recordList = jsonArr.map<CalendarFitModel>((item) => CalendarFitModel.fromJson(item)).toList();
      }
    } else {
      TKToast.showError(result.message);
    }
    return recordList;
  }
}