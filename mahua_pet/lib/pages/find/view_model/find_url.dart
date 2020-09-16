
class FindURL {
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

  /// 发现--视频列表: user/message/selectCurrentVideoPage?messageId=29801&orderColumn=create_time&pageIndex=1&pageSize=10&userLoginId=136899
  static const String selectCurrentVideoPage = 'user/message/selectCurrentVideoPage';
  
  /// 话题讨论: user/messageLabel/getMessageAndReportBylabel?messageLabelId=399&orderType=1&pageIndex=1&pageSize=10&userLoginId=136899
  /// orderType: 热门1, 最新2
  static const String getMessageBylabel = 'user/messageLabel/getMessageAndReportBylabel';


}