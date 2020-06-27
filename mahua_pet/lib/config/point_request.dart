
import 'package:mahua_pet/providered/model/model_index.dart';

import 'http_request.dart';
import 'http_config.dart';

class PointRequest {

  // 用户信息埋点
  static void eventBaseRequest(String eventName, String token, int userId) {
    final params = {'eventName': eventName, 'token': token, 'userId': '$userId'};
    HttpRequest.request(HttpConfig.putEventBase, method: 'post', params: params)
      .then((value) {
        if (value.isSuccess) {
          Map<String, dynamic> json = value.data;
          ConfigInfo.fromJson(json);
        } else {
        }
      });
  }
}