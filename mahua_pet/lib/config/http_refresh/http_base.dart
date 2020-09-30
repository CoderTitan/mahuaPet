import 'dart:convert';
import 'dart:io';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';

import 'http_config.dart';


// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}


/// 配置请求拦截器
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = HttpConfig.timeout;
    options.receiveTimeout = HttpConfig.timeout;
    options.baseUrl = HttpConfig.baseURL;
    options.headers = getHeader();
    return options;
  }

  static Map<String, dynamic> getHeader() {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    ConfigInfo configInfo = SharedStorage.configInfo;
    DeviceInfoModel deviceInfo = SharedStorage.deviceInfo;

    Map<String, dynamic> headers = {
      'Accept': '*/*',
      'H5Auth': '0',

      // 渠道信息
      'channel': 'AppStore',
      'terminal': Platform.operatingSystem ?? 'iOS',
      'platformType': '0',

      // 版本和用户信息
      // 'clientVersion': configInfo.clientVersion,
      'clientVersion': '3.1.8',
      'Authorization': loginInfo.token,
      'loginType': configInfo.loginType,

      // 设备信息
      'deviceBrand': 'Apple',
      'deviceModel': configInfo.deviceModel,
      'sysVersion': configInfo.sysVersion,
      // 'IMEI': loginInfo.,
      'deviceNo': configInfo.deviceNo,
      
      // 位置信息
      // 'province': await SharedUtils.getString(ShareConstant.province),
      // 'city': await SharedUtils.getString(ShareConstant.city),
      // 'area': await SharedUtils.getString(ShareConstant.area),
    };
    return headers;
  }
}


abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;
  bool isSuccess;

  BaseResponseData({this.code, this.message, this.data, this.isSuccess});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

