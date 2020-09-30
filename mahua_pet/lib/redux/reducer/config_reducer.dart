import 'package:flutter/material.dart';
import 'package:redux/redux.dart';



/// 创建 Reducer<State> 
final WelcomeReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshShowWelcomeAction>(_refreshWelcome),
]);

bool _refreshWelcome(bool showWelcome, action) {
  showWelcome = action.showWelcome;
  return showWelcome;
}

class RefreshShowWelcomeAction {
  final bool showWelcome;

  RefreshShowWelcomeAction(this.showWelcome);
}