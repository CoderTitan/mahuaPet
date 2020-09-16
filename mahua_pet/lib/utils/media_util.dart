import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mahua_pet/component/component.dart';
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