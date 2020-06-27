
import 'package:mahua_pet/config/config_index.dart';

class FindViewModel {
  
  static Future<Map<String, dynamic>> requestMovieList() async {
    // 1.构建URL
    // final url = 'common/addThreadAdvClick';
    final url = 'user/common/sendCode?phone=13456789417';

    // 2.发送网络请求获取结果
    // final result = await HttpRequest.request(url, method: 'post', params: params);
    final result = await HttpRequest.request(url);

    return result;
  }

}