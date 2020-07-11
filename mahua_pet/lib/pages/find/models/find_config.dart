

enum FindActionType {
  // 进入详情页面
  detail,
  // 点击头像, 进入个人主页
  header,
  // 点赞
  agree,
  // 收藏
  collection,
  // 关注
  attation,
  // 评论
  comment,
  // 分享
  share,
  // 空
  none
}


typedef FindActionCallBack = void Function(FindActionType type);