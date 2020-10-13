

import 'view_state_model.dart';

abstract class ViewRefresh<T> extends ViewStateModel {
  
  /// 页面数据
  List<T> list = [];

  /// 第一次进入页面loading
  initDatas() async {
    setBusy();
    await refreshData(init: true);
  }

  /// 下拉刷新
  refreshData({bool init = false}) async {
    try {
      List<T> datas = await loadData();
      if (datas.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        onCompleted(datas);
        list.clear();
        list.addAll(datas);
        setIdle();
      } 
    } catch (e, s) {
      if (init) list.clear();
      setError(e, s);
    }
  }

  /// 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}