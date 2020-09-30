
class TKImages {

  static String asset(String path) {
    return image_path + path + '.png';
  }

  // 所有的图片路径
  static const image_path = 'resource/images/';

  /// 占位头像
  static const user_header = 'resource/images/user_header.png';
  /// 空数据占位图
  static const empty_data = 'resource/images/empty_data.png';
  /// 显示图片展位图
  static const image_empty = 'resource/images/find_empty_img.png';
  static const video_empty = 'resource/images/find_none_image.png';

  // tabbar
  static const tabbar_home_select = 'resource/images/tabbar_home_select.png';
  static const tabbar_home_unselect = 'resource/images/tabbar_home_noselect.png';
  static const tabbar_school_select = 'resource/images/tabbar_school_select.png';
  static const tabbar_school_unselect = 'resource/images/tabbar_school_noselect.png';
  static const tabbar_add = 'resource/images/tabbar_add.png';
  static const tabbar_find_select = 'resource/images/tabbar_device_select.png';
  static const tabbar_find_unselect = 'resource/images/tabbar_device_noselect.png';
  static const tabbar_mine_select = 'resource/images/tabbar_mine_select.png';
  static const tabbar_mine_unselect = 'resource/images/tabbar_mine_noselect.png';
}