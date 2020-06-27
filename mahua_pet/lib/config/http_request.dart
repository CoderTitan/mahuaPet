import 'package:dio/dio.dart';

import 'http_config.dart';
import 'http_data.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/shared/shared_index.dart';

class HttpRequest {
  
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseURL, 
    connectTimeout: HttpConfig.timeout,
  );
  static final Dio dio = Dio(baseOptions);


  static Future<T> request<T>(String url, {
    String method = "get",
    Map<String, dynamic> params,
    Interceptor inter}) async {
    // 1.创建单独配置
    final options = Options(method: method);

    Map<String, dynamic> header = await getHeader();
    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (options) {
          options.headers = header;
          print("请求接口: ${options.baseUrl}url");
          print("请求参数: $params");
          return options;
        },
        onResponse: (response) {
          print("响应结果: ${response.data}");
          return response;
        },
        onError: (err) {
          switch (err.type) {
            case DioErrorType.CONNECT_TIMEOUT:
              TKToast.showToast('请求超时, 请稍后再试');
              break;
            case DioErrorType.SEND_TIMEOUT:
              TKToast.showToast('请求超时, 请稍后再试');
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              TKToast.showToast('请求超时, 请稍后再试');
              break;
            case DioErrorType.RESPONSE:
              TKToast.showToast('当前网络不可用，请检查你的网络设置');
              break;
            case DioErrorType.CANCEL:
              TKToast.showToast('请求取消, 请稍后再试');
              break;
            default:
              TKToast.showToast('请求失败，请稍后再试');
          }
          
          return err;
        }
    );
    List<Interceptor> inters = [dInter];

    // 请求单独拦截器
    if (inter != null) {
      inters.add(inter);
    }

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);

    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
        Map<String, dynamic> data = response.data ?? {};
        dynamic result = HttpData.fromJson(data);
        return result;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }

  static Future<T> getHeader<T>() async {
    dynamic headers = {
      'Accept': '*/*',
      'H5Auth': '0',

      // 渠道信息
      'channel': 'AppStore',
      'terminal': 'iOS',
      'platformType': '0',

      // 版本和用户信息
      'clientVersion': await SharedUtils.getString(ShareConstant.clientVersion),
      'Authorization': await SharedUtils.getString(ShareConstant.token),
      'loginType': await SharedUtils.getString(ShareConstant.loginType),

      // 设备信息
      'deviceBrand': 'Apple',
      'deviceModel': await SharedUtils.getString(ShareConstant.deviceModel),
      'sysVersion': await SharedUtils.getString(ShareConstant.sysVersion),
      // 'IMEI': await SharedUtils.getString(ShareConstant.loginType),
      'deviceNo': await SharedUtils.getString(ShareConstant.deviceNo),
      
      // 位置信息
      // 'province': await SharedUtils.getString(ShareConstant.province),
      // 'city': await SharedUtils.getString(ShareConstant.city),
      // 'area': await SharedUtils.getString(ShareConstant.area),
    };
    print('headers = $headers');
    return headers;
  }
}