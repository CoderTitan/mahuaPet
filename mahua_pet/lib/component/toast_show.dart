
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mahua_pet/styles/app_style.dart';

class TKToast {
  static void showToast(String msg) {
    // setToastStyle();
    EasyLoading.showToast(msg);
  }

  static void showLoading() {
    // setToastStyle();
    EasyLoading.show(status: '加载中...');
  }

  static void showSuccess(String msg) {
    // setToastStyle();
    EasyLoading.showSuccess(msg);
  }

  static void showError(String msg) {
    // setToastStyle();
    EasyLoading.showError(msg);
  }

  static void showWarn(String msg) {
    // setToastStyle();
    EasyLoading.showInfo(msg);
  }

  static void showProgress(double value, {String status = '正在保存...'}) {
    // setToastStyle();
    EasyLoading.showProgress(value, status: status);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void setToastStyle() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Color(0xCC000000)
      ..indicatorColor = Colors.white
      ..progressColor = Colors.white
      ..textColor = Colors.white
      ..fontSize = 15
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..userInteractions = false;
  }
}