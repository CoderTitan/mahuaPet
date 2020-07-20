import 'package:dio/dio.dart';
import 'package:mahua_pet/providered/model/config_info.dart';
import 'package:mahua_pet/providered/model/login_info.dart';
import 'package:provider/provider.dart';

import 'http_config.dart';
import 'http_data.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';

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

    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (options) {
          options.headers = getHeader();
          print("请求接口: ${options.baseUrl}$url");
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
              TKToast.showToast('请求失败，请稍后再试');
              break;
            case DioErrorType.CANCEL:
              TKToast.showToast('请求取消, 请稍后再试');
              break;
            default:
              TKToast.showToast('当前网络不可用，请检查你的网络设置');
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

  static Map<String, dynamic> getHeader() {
    LoginInfo loginInfo = SharedStorage.loginInfo;
    ConfigInfo configInfo = SharedStorage.configInfo;
    DeviceInfoModel deviceInfo = SharedStorage.deviceInfo;

    Map<String, dynamic> headers = {
      'Accept': '*/*',
      'H5Auth': '0',

      // 渠道信息
      'channel': 'AppStore',
      'terminal': 'iOS',
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
    print('请求头: headers = $headers');
    return headers;
  }
}