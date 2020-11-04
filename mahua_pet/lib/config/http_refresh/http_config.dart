
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

  /// 首页种草列表: auditStatus=1&pageIndex=1&pageSize=10&userLoginId=136899
  static const String getTrialReportList = 'user/trialReport/getTrialReportList';

  /// 首页推荐列表: messageTotal=0&pageIndex=1&reportTotal=0&thirtyPieces=1&userLoginId=136899
  static const String selectMessageRecommendList = 'user/message/selectMessageRecommendList';

  /// 首页种草列表: post: /user/trialReport/getTrialReportInfo
  static const String getTrialReportInfo = 'user/trialReport/getTrialReportInfo';
  
  /// 首页种草点赞: post: user/agree/updateTrialReportAgree
  static const String updateTrialReportAgree = 'user/agree/updateTrialReportAgree';

  /// 首页种草收藏: post: user/collections/update
  static const String collectionApi = 'user/collections/update';



  /**
   * 日历部分
   */
  /// 日历记录天数: /user/growManager/selectGrowManagerList?petId=19985&year=2020
  /// 日历某一天的记录: user/growManager/selectGrowManagerList?day=10&month=09&petId=19985&year=2020
  static const String selectGrowManagerList = 'user/growManager/selectGrowManagerList';

  /// 日历每天的可记录项: /user/growManager/selectManagerDetailByGrowManagerId?growManagerId=25010
  static const String selectManagerDetailByGrowManagerId = 'user/growManager/selectManagerDetailByGrowManagerId';

  /// 日历每天的医疗记录: user/diseaseRecords/selectRecordsListByManagerId?growManagerId=25010&pageIndex=1&pageSize=10
  static const String selectRecordsListByManagerId = 'user/diseaseRecords/selectRecordsListByManagerId';

  /// 保存日常记录/体重(post): user/templePetValue/save, 
  /// {"growTempleId":"9","growManagerId":31755,"value":"13,14","templePetValueId":27342,"petId":"19985"}
  /// post: {"growTempleId":"9","growManagerId":33376,"value":"14","petId":"19985"}
  static const String record_save = 'user/templePetValue/save';

  /// 添加医疗记录: user/diseaseRecords/save
  /// post: {"userId":136899,"symptom":"亲","fileIds":"68088","diagnosticResult":"这","day":"26","month":"10","growManagerId":33376,"year":"2020","desc":"是不是"}
  static const String fit_save = 'user/diseaseRecords/save';

  /// 添加日常小计: user/templePetValue/save
  






  /**
   * 我的部分
   */
  /// 个人主页--日记: user/message/selectPageList?pageIndex=1&pageSize=10&userId=530&userLoginId=136899

  /// 个人主页-种草: user/trialReport/getTrialReportList?auditStatus=1&pageIndex=1&pageSize=10&userId=530&userLoginId=136899

  /// 个人主页-提问: user/question/v1911/lik/selectMyQuestionList?pageIndex=1&pageSize=10&userId=530

  /// 个人主页-答案: user/question/v1911/lik/selectMyAnswerList?orderType=1&pageIndex=1&pageSize=10&userId=530
  /// 个人主页-粉丝列表: https://gate.ieasydog.com/api/user/relation/selectAttentionMeById?pageIndex=1&pageSize=10&userId=1204&userLoginId=136899
  /// 个人主页-关注列表: https://gate.ieasydog.com/api/user/relation/selectMyAttention?pageIndex=1&pageSize=10&userId=1204&userLoginId=136899
  /// 保存用户信息: https://gate.ieasydog.com/api/user/userinfo/save
  /// {"sex":"M","nickname":"铲屎官06209417","userinfoId":139260}

  /// 我的收藏: user/collections/getMyCollectionsByCollectionType?collectionsType=0&pageIndex=1&pageSize=10&userId=136899
  /// 消息个数: https://gate.ieasydog.com/api/user/user/userMessageCount?userId=136899
  /// 系统消息列表: https://gate.ieasydog.com/api/user/sysMsg/selectPageOfUser?pageIndex=1&pageSize=10&userId=136899
  /// 系统消息详情: https://gate.ieasydog.com/api/user/messageLabel/getMessageAndReportBylabel?messageLabelId=393&orderType=1&pageIndex=1&pageSize=10&userLoginId=136899
  /// 系统消息标题: https://gate.ieasydog.com/api/user/messageLabel/getMessageLabelTopInfo?messageLabelId=393
  /// 消息-点赞列表: https://gate.ieasydog.com/api/user/user/selectAgreeList?pageIndex=1&pageSize=10&userId=136899
  /// 消息-收藏列表: https://gate.ieasydog.com/api/user/user/v2006/wjt/selectCollectList?pageIndex=1&pageSize=10&userId=136899
  /// 消息评论列表: https://gate.ieasydog.com/api/user/user/selectCommentList?pageIndex=1&pageSize=10&userId=136899
  /// 消息@我列表: https://gate.ieasydog.com/api/user/user/selectAtUserList?pageIndex=1&pageSize=10&userId=136899
}

