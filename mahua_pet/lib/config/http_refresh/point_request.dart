
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'http_request.dart';
import 'http_config.dart';

class PointRequest {

  // 用户信息埋点
  static Future<ConfigInfo> eventBaseRequest(
    String eventName, 
    String token, 
    int userId
  ) async {
    final params = {'eventName': eventName, 'token': token, 'userId': '$userId'};
    final value = await TKRequest.requestData(HttpConfig.putEventBase, method: 'post', params: params);

    ConfigInfo configInfo = ConfigInfo();
    if (value.isSuccess) {
      if (value.data == null) {
        return ConfigInfo();
      }
      Map<String, dynamic> mapJson = value.data;
      configInfo = ConfigInfo.fromJson(mapJson);
    }
    SharedStorage.configInfo = configInfo;
    return configInfo;
  }

  // 请求用户相关信息
  static Future<UserData> requestUser(int userId) async {
    final url = '${HttpConfig.userIndex}?userId=$userId';
    final value = await TKRequest.requestData(url);
    if (value.isSuccess) {
      if (value.data == null) {
        return UserData();
      }
      Map<String, dynamic> mapJson = value.data;
      return UserData.fromJson(mapJson);
    }
    return UserData();
  }
}