import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'view_refresh.dart';

abstract class ViewListRefresh<T> extends ViewRefresh<T> {
  /// 分页条目数量
  static const int pageSize = 10;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int currentPage = 1;


  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  /// 上拉加载更多
  Future<List<T>> refreshData({bool init = false}) async {
    try {
      currentPage = 1;
      var data = await loadData(pageIndex: currentPage);
      if (data.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();

        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        TKToast.dismiss();
        setIdle();
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
      TKToast.dismiss();
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMoreData() async {
    try {
      final pageIndex = currentPage + 1;
      var data = await loadData(pageIndex: pageIndex);
      if (data.isEmpty) {
        refreshController.loadNoData();
      } else {
        currentPage++;
        onCompleted(data);
        list.addAll(data);
        refreshController.refreshCompleted();

        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      TKToast.dismiss();
      return data;
    } catch (e, s) {
      refreshController.loadFailed();
      TKToast.dismiss();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  /// 加载数据
  Future<List<T>> loadData({int pageIndex});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}