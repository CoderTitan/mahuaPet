
class HttpConfig {

  static const bool isFormat = true;
  static const String baseURL = "https://gate.ieasydog.com/api/";
  static const int timeout = 30000;


  // 相关接口
  // 上传设备信息
  static const String imei = 'user/imei/v2006/wjt/imei';
  // 用户信息埋点
  static const String putEventBase = 'user/eventBase/v1908/wjt/putEventBase';
  
  // 获取验证码, get, phone=13456789417
  static const String sendCode = 'user/common/sendCode';
  // 密码登录
  static const String applogin = 'user/user/applogin';


  // 获取用户信息
  static const String userIndex = 'user/userIndex';
}

