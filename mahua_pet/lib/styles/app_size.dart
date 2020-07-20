import 'dart:ui';
import 'dart:io';

class SizeFit {

  /// 是否是安卓系统
  static bool isAndroid = Platform.isAndroid;
  /// 是否是iOS系统
  static bool isIOS = Platform.isIOS;

  // 像素宽高
  static double physicalWidth;
  static double physicalHeight;

  // 实际尺寸
  static double screenWidth;
  static double screenHeight;
  static double statusHeight;
  static double navHeight;
  static double safeHeight;
  static double tabBarHeight;

  // 是否是刘海屏
  static bool isIPhoneX;

  // 像素比例
  static double dpr;
  // 适配相比于参考机型的像素比
  static double rpx;
  // 适配相比于参考机型的尺寸比
  static double px;



  // 参考机型为iPhone 7(375*667)
  static void initialize({double standardSize = 750}) {
    // 手机的物理sc
    physicalWidth = window.physicalSize.width;
    physicalHeight =window.physicalSize.height;
    dpr = window.devicePixelRatio;

    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;
    statusHeight = window.padding.top / dpr;
    isIPhoneX = screenHeight >= 812;
    navHeight = statusHeight + 44;
    tabBarHeight = isIPhoneX ? 83 : 49;
    safeHeight = isIPhoneX ? 34 : 0;


    // 计算比例的大小
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }


  // 设置对应比例的尺寸
  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }
}