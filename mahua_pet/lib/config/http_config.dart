
class HttpConfig {

  /// 请求配置参数
  static const bool isFormat = true;
  static const String baseURL = "https://gate.ieasydog.com/api/";
  static const int timeout = 30000;


  /*
   * 登录注册相关接口
   */
  // 上传设备信息
  static const String imei = 'user/imei/v2006/wjt/imei';
  // 用户信息埋点
  static const String putEventBase = 'user/eventBase/v1908/wjt/putEventBase';
  
  // 获取验证码, get, phone=13456789417
  static const String sendCode = 'user/common/sendCode';
  // 密码登录
  static const String applogin = 'user/user/applogin';

  // 获取用户信息
  static const String userIndex = 'user/user/userIndex';


  /*
   * 宠物相关接口
   */
  // 获取宠物列表: https://gate.ieasydog.com/api/user/pet/selectUserId?userId=136899
  static const String selectUserId = 'user/pet/selectUserId';
  // 获取宠物和问答信息: /api/user/pet/v2001/lt/getHomePagePetList?pageIndex=1&pageSize=1&petId=19572&userId=136899
  static const String getHomePagePetList = 'api/user/pet/v2001/lt/getHomePagePetList';
  // 保存宠物信息: /api/user/pet/save
  static const String pet_save = 'user/pet/save';



  /*
   * 首页相关接口
   */
  // 轮播图: discover/advertUnit/selectPageList?locationName=2&locationPage=1
  static const String selectPageList = 'discover/advertUnit/selectPageList';
}

