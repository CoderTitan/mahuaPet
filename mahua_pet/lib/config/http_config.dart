
class HttpConfig {

  /// 请求配置参数
  static const bool isFormat = true;
  static const String baseURL = "https://gate.ieasydog.com/api/";
  static const int timeout = 30000;


  /*
   * 登录注册相关接口
   */
  /// 上传设备信息
  static const String imei = 'user/imei/v2006/wjt/imei';
  /// 用户信息埋点
  static const String putEventBase = 'user/eventBase/v1908/wjt/putEventBase';
  
  /// 获取验证码, get, phone=13456789417
  static const String sendCode = 'user/common/sendCode';
  /// 密码登录
  static const String applogin = 'user/user/applogin';

  /// 获取用户信息
  static const String userIndex = 'user/user/userIndex';


  /*
   * 宠物相关接口
   */
  /// 获取宠物列表: https://gate.ieasydog.com/api/user/pet/selectUserId?userId=136899
  static const String selectUserId = 'user/pet/selectUserId';

  /// 获取宠物和问答信息: /api/user/pet/v2001/lt/getHomePagePetList?pageIndex=1&pageSize=1&petId=19572&userId=136899
  static const String getHomePagePetList = 'api/user/pet/v2001/lt/getHomePagePetList';

  /// 保存宠物信息: /api/user/pet/save
  static const String pet_save = 'user/pet/save';



  /*
   * 首页相关接口
   */
  /// 轮播图: discover/advertUnit/selectPageList?locationName=2&locationPage=1
  static const String selectPageList = 'discover/advertUnit/selectPageList';


  /**
   * 发现相关接口
   */
  /// 发现轮播图: /user/messageLabel/v2006/lt/selectMessageLabelList?pageIndex=1&pageSize=5
  static const String selectMessageLabelList = 'user/messageLabel/v2006/lt/selectMessageLabelList';

  /// 发现--推荐接口: user/message/selectMessageRecommendList?messageTotal=8022&pageIndex=2&reportTotal=483&userLoginId=136899
  static const String selectMessageRecommendList = 'user/message/selectMessageRecommendList';

  /// 发现-附近: /user/message/getMessageNearby?latitude=30.285382&longitude=120.036424&pageIndex=1&pageSize=10&total=0&userLoginId=136899
  static const String getMessageNearby = 'user/message/getMessageNearby';

  /// 发现-动态详情: user/message/detail?messageId=29720&userId=136899
  static const String find_detail = 'user/message/detail';

  /// 发现关注-推荐关注列表: user/relation/selectNotRelation?pageIndex=1&pageSize=3&userLoginId=136899
  static const String selectNotRelation = 'user/relation/selectNotRelation';

  /// 发现关注-动态列表: user/message/selectPageList?listType=2&pageIndex=2&pageSize=10&total=388&userLoginId=136899
  static const String user_selectNotRelation = 'user/message/selectPageList';

  /// 发现-点赞: user/agree/updateAgree?agreeStatus=0&messageId=29720&userId=136899
  /// 点赞评论: agreeStatus=0&commentId=34161&userId=136899
  /// agreeStatus: 0点赞, 1: 取消
  static const String updateAgree = 'user/agree/updateAgree';

  /// 发现-收藏(post): user/collections/update
  /// collectionsStatus=0&messageId=29716&token=&userId=136899
  /// collectionsStatus: 0收藏, 1取消
  static const String user_collection = 'user/collections/update';

  /// 发现-评论列表: user/comment/selectCommentPage?messageId=29716&pageIndex=1&pageSize=10&replySize=5&userId=136899&userLoginId=136899
  static const String selectCommentPage = 'user/comment/selectCommentPage';

  /// 发现-评论内容(post): user/comment/save
  /// commentInfo=&messageId=29716&token=&userId=136899
  static const String comment_save = 'user/comment/save';

  /// 发现-评论-二级评论内容(post): user/commentReply/save
  /// beReplyedUserId=120987&commentId=35318&commentInfo=&replyUserId=136899&token=
  static const String comment_reply_save = 'user/commentReply/save';

  /// 发现-删除评论: user/comment/delete?commentId=35327&userLoginId=136899
  static const String comment_delete = 'user/comment/delete';

  /// 发现-关注: user/relation/UpdateAttation?isFlag=0&userByid=147280&userId=136899
  /// isFlag: 0关注, 1取消关注
  static const String updateAttation = 'user/relation/UpdateAttation';

  /// 发现-关注列表: user/relation/selectMyAttention?pageIndex=1&pageSize=15&userId=136899&userLoginId=136899
  static const String selectMyAttention = 'user/relation/selectMyAttention';


}

