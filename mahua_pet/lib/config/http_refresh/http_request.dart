import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:mahua_pet/component/toast_show.dart';
import 'package:mahua_pet/config/http_refresh/http_base.dart';


final TKRequest tkhttp = TKRequest();

class TKRequest extends BaseHttp {

  @override
  void init() {
    interceptors.add(ApiInterceptor());
  }

  static Future<T> getRequest<T>(String url) async {
    return requestData(url);
  }

  static Future<T> postRequest<T>(String url, Map<String, dynamic> params) async {
    return requestData(url, method: 'post', params: params);
  }

  static Future<T> requestData<T>(String url, {
    String method = "get",
    Map<String, dynamic> params,
    Interceptor inter}) async {

    final options = Options(method: method);
    try {
      Response response = await tkhttp.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      TKToast.showError('请求失败, 请重试');
      return Future.error(e);
    }
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    debugPrint('url--> ${options.baseUrl}${options.path}' + ' queryParameters: ${options.queryParameters}');
    return options;
  }

  @override
  Future onResponse(Response response) {
    print('response = ${response.data}');
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.isSuccess) {
      response.data = respData;
      return tkhttp.resolve(response);
    } else {
      TKToast.showError(respData.message);
      throw NotSuccessException.fromRespData(respData);
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['status'];
    message = json['message'];
    data = json['data'];
    isSuccess = json['rel'];
  }
}