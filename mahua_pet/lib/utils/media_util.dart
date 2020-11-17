import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_style.dart';
import './permission_util.dart';





class TKMediaUtil {

  /// 保存普通图片到相册: png, jpg等
  static void saveImage(BuildContext context, String imageURL) async {
    final permission = await TKPermissionUtil.perssionRequest(context, TKPermission.photos);
    if (!permission) { return; }

    final response = await Dio().get(imageURL, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: 'image'
    );
    if (result) {
      TKToast.showSuccess('图片保存成功');
    } else {
      TKToast.showError('图片保存失败');
    }
  }

  /// 保存二进制图片到相册: ByteData
  static void saveByteImage(BuildContext context, GlobalKey key) async {
    final permission = await TKPermissionUtil.perssionRequest(context, TKPermission.photos);
    if (!permission) { return; }

    final imageData = await imageToByteData(key);
    if (imageData == null) return;

    final result = await ImageGallerySaver.saveImage(
      imageData.buffer.asUint8List(),
      quality: 100,
      name: 'image'
    );
    if (result != null) {
      TKToast.showSuccess('图片保存成功');
    } else {
      TKToast.showError('图片保存失败');
    }
  }

  /// 保存Gif图片到相册
  static void saveGifImage(BuildContext context, String imageURL) async {
    final permission = await TKPermissionUtil.perssionRequest(context, TKPermission.photos);
    if (!permission) { return; }
    
    final appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.gif";

    await Dio().download(imageURL, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    if (result) {
      TKToast.showSuccess('图片保存成功');
    } else {
      TKToast.showError('图片保存失败');
    }
  }


  /// 获取图片流ByteData
  static Future<ByteData> imageToByteData(GlobalKey key) async {
    BuildContext currentCtx = key.currentContext;
    if (currentCtx != null) {
      try {
        RenderRepaintBoundary boundary = currentCtx.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: SizeFit.dpr);
        ByteData imgData = await image.toByteData(format: ui.ImageByteFormat.png);
        return imgData;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return null;
  }


  /// 保存视频到相册
  static void saveVideo(BuildContext context, String imageURL) async {
    final permission = await TKPermissionUtil.perssionRequest(context, TKPermission.photos);
    if (!permission) { return; }
    
    final appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";


    await Dio().download(imageURL, savePath, onReceiveProgress: (count, total) {
      final progress = count / total;
      TKToast.showProgress(progress);
    });
    final result = await ImageGallerySaver.saveFile(savePath);

    if (result) {
      TKToast.showSuccess('视频保存成功');
    } else {
      TKToast.showError('视频保存失败');
    }
  }




  
}