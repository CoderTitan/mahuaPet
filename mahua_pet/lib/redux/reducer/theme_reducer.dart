import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


/************* 主题管理 *************/
/// 创建 Reducer<State> 
final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refreshTheme),
]);

final NightModalReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshNightModalAction>(_refreshNight),
]);


/// 定义Action操作
ThemeData _refreshTheme(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

bool _refreshNight(bool nightModal, action) {
  nightModal = action.nightModal;
  return nightModal;
}

/// 定义一个Action类
class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}

class RefreshNightModalAction {
  final bool nightModal;

  RefreshNightModalAction(this.nightModal);
}
/************* end *************/




/************* 语言管理 *************/
/// 多语言 Reducer<State> 
final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocaleAction>(_refreshLocale),
]);

Locale _refreshLocale(Locale locale, RefreshLocaleAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocaleAction {
  final Locale locale;

  RefreshLocaleAction(this.locale);
}
/************* end *************/
