

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
  // 点击评论
  commentSelect,
  // 分享
  share,
  // 空
  none
}


/// 个人主页事件类型
enum FindHeaderActionType {
  fansList,
  focusList,
  agreeList,

}

/// 发现列表点击事件
typedef FindActionCallBack = void Function(FindActionType type);
/// 个人主页header事件
typedef FindHeaderCallback = void Function(FindHeaderActionType type);

/// 评论提交
typedef ActionTextSubmit = void Function(String text);