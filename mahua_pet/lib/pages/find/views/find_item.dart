
import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/providered/provider_index.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/utils/route_util.dart';

import '../contents/content_index.dart';
import '../view_model/view_model_index.dart';
import '../models/model_index.dart';
import 'find_item_video.dart';
import 'find_item_image.dart';


class FindListItem extends StatelessWidget {

  final FocusPostModel model;
  final FindActionCallBack actionCallback;
  
  FindListItem({Key key, this.model, this.actionCallback}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConsumerProvider<FindItemProvider>(
      model: FindItemProvider(),
      builder: (_, itemVM, child) {
        return GestureDetector(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getItemList(context, itemVM)
                ),
              ),
              Container(height: 10.px, color: TKColor.color_f7f7f7)
            ],
          ),
          onTap: () {
            jumpFindDetail(context, itemVM);
          },
        );
      },
    );
  }

  List<Widget> getItemList(BuildContext context, FindItemProvider itemVM) {
    final _postModel = itemVM.postModel ?? model;

    List<Widget> itemList = [];
    itemList.add(userInfoItem(context, itemVM));

    if (_postModel.messageInfo != null && _postModel.messageInfo.isNotEmpty) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderTextItem(_postModel));
    }

    if (_postModel.fileCount > 0) {
      itemList.add(renderMediaItems(context, itemVM));
    }

    if (_postModel.userInfo.city != null && _postModel.userInfo.city.isNotEmpty) {
      itemList.add(renderLocationItem(_postModel));
    }

    if (_postModel.commentList.length > 0) {
      itemList.add(SizedBox(height: 10.px));
      itemList.add(renderCommonList(_postModel));
    }

    itemList.add(SizedBox(height: 8.px));
    itemList.add(Divider(color: TKColor.color_e8e8e8, height: 0.5));
    itemList.add(renderBottomItem(itemVM));
    return itemList;
  }

  Widget userInfoItem(BuildContext context, FindItemProvider itemVM) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: renderHeaderItems(context, itemVM),
    );
  }

  List<Widget> renderHeaderItems(BuildContext context, FindItemProvider itemVM) {
    final postModel = itemVM.postModel ?? model;
    List<Widget> itemList = [];

    Widget user = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: TKNetworkImage(
            imageUrl: postModel.userInfo.headImg,
            width: 45.px, height: 45.px,
            boxRadius: 30.px,
            fit: BoxFit.cover,
            placeholder: TKImages.user_header,
          ),
          onTap: () {
            jumpFindUserPage(context, itemVM);
          },
        ),
        SizedBox(width: 8.px),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(postModel.userInfo.nickname, style: TextStyle(fontSize: 15.px, color: TKColor.color_333333)),
            Text(postModel.createTime, style: TextStyle(fontSize: 11.px, color: TKColor.color_999999)),
          ],
        )
      ],
    );
    itemList.add(user);

    LoginInfo loginInfo = SharedStorage.loginInfo;
    if (loginInfo.userId != postModel.userId) {
      Widget button = FocusButton(
        isSelect: postModel.followStatus != '未关注',
        onPressed: () {
          itemVM.requestFocusState(postModel, (type) {
            actionCallback(type);
          });
        }
      );
      itemList.add(button);
    }

    return itemList;
  }

  Widget renderTextItem(FocusPostModel postModel) {
    return Text(
      postModel.messageInfo ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14.px, color: TKColor.color_333333),
    );
  }

  Widget renderMediaItems(BuildContext context, FindItemProvider itemVM) {
    final postModel = itemVM.postModel ?? model;
    final media = postModel.fileList.first;
    if (media.fileType == '0') {
      return renderImages(context, postModel);
    } else if (media.fileType == '1') {
      return renderVideoItem(context, itemVM);
    }
    return Container();
  }

  Widget renderImages(BuildContext context, FocusPostModel postModel) {
    final imgArray = postModel.fileList;
    if (imgArray.length == 1) {
      final imgModel = imgArray.first;
      return Container(
        padding: EdgeInsets.only(top: 8.px),
        child: FindItemImage(
          imageUrl: imgModel.fileUrl,
          width: 140.px,
          height: 180.px,
          radius: 10.px,
          onPress: () {
            TKRoute.pushImagePreview(context, PhotoPreview(index: 0, images: [imgModel.fileUrl]));
          },
        ),
      );
    }
    final imageWidth = imgArray.length == 4 ? 120.px : 107.px;
    return Container(
      padding: EdgeInsets.only(top: 8.px),
      child: Wrap(
        spacing: 10.px,
        runSpacing: 10.px,
        children: imgArray.map((item) {
          final itemIndex = imgArray.indexOf(item) ?? 0;
          return FindItemImage(
            key: ValueKey(itemIndex),
            imageUrl: item.fileUrl,
            width: imageWidth,
            height: imageWidth,
            radius: 4.px,
            onPress: () {
              List<String> images = imgArray.map((e) => e.fileUrl).toList();
              TKRoute.pushImagePreview(context, PhotoPreview(index: itemIndex, images: images));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget renderVideoItem(BuildContext context, FindItemProvider itemVM) {
    final postModel = itemVM.postModel ?? model;
    final imgArray = postModel.fileList;
    final imgModel = imgArray.first;
    return GestureDetector(
      child: FindVideoItem(videoURL: imgModel.fileUrl),
      onTap: () {
        jumpFindDetail(context, itemVM);
      },
    );
  }

  Widget renderLocationItem(FocusPostModel postModel) {
    return Container(
      padding: EdgeInsets.only(top: 8.px),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on, size: 16.px, color: TKColor.color_666666),
          SizedBox(width: 4.px),
          Text(postModel.userInfo.city, style: TextStyle(fontSize: 13.px, color: TKColor.color_6f6f6f))
        ],
      ),
    );
  }

  Widget renderCommonList(FocusPostModel postModel) {
    return Container(
      padding: EdgeInsets.all(8.px),
      width: SizeFit.screenWidth - 32.px,
      decoration: BoxDecoration(
        color: TKColor.color_f7f7f7,
        borderRadius: BorderRadius.circular(4.px)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderCommonChildren(postModel.commentList)
      ),
    );
  }

  List<Widget> renderCommonChildren(List<CommentModel> commonList) {
    List<CommentModel> newList = commonList.length > 3 ? commonList.sublist(0, 3) : commonList;
    List<Widget> commonWidgets = [];
    for (var i = 0; i < newList.length; i++) {
      CommentModel item = newList[i];
      Widget span = Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Text(item.nickname + ': ', style: TextStyle(fontSize: 13.px, color: TKColor.color_526e94)),
              alignment: PlaceholderAlignment.middle
            ),
            ...item.commentInfo.runes.map((rune) {
              return WidgetSpan(
                child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 13.px, color: TKColor.color_666666)),
                alignment: PlaceholderAlignment.middle
              );
            }).toList()
          ]
        ),
        softWrap: true,
      );
      commonWidgets.add(span);
      if (i < newList.length - 1) {
        commonWidgets.add(SizedBox(height: 3.px));
      }
    }

    if (commonList.length > 3) {
      commonWidgets.add(SizedBox(height: 5.px));
      Widget spanIcon = Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Text('查看更多评论', style: TextStyle(fontSize: 13.px, color: TKColor.color_526e94)),
              alignment: PlaceholderAlignment.middle
            ),
            WidgetSpan(
              child: Icon(Icons.keyboard_arrow_right, size: 20.px, color: TKColor.color_526e94),
              alignment: PlaceholderAlignment.middle
            )
          ]
        ),
      );
      commonWidgets.add(spanIcon);
    }

    return commonWidgets;
  }

  Widget renderBottomItem(FindItemProvider itemVM) {
    return Container(
      height: 40.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getBottomItem(itemVM),
      ),
    );
  }

  List<Widget> getBottomItem(FindItemProvider itemVM) {
    final _postModel = itemVM.postModel ?? model;
    List<Widget> itemList = [];

    Widget agreeItem = GestureDetector(
      child: bottomItem(
        _postModel.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
        _postModel.agreeStatus == '1' ? TKColor.main_color : TKColor.color_666666,
        '${_postModel.cntAgree}',
      ),
      onTap: () {
        itemVM.requestAgreeState(_postModel);
      },
    );
    itemList.add(agreeItem);
    itemList.add(bottomItem(Icons.message, TKColor.color_666666, '${_postModel.cntComment}'));
    itemList.add(bottomItem(Icons.share, TKColor.color_666666, ''));

    return itemList;
  }

  Widget bottomItem(IconData icon, Color iconColor, String number) {
    return Container(
      width: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 20.px, color: iconColor,),
          SizedBox(width: 3.px),
          Text(number, style: TextStyle(fontSize: 13.px, color: TKColor.color_666666))
        ],
      ),
    );
  }

  void jumpFindDetail(BuildContext context, FindItemProvider itemVM) {
    final _model = itemVM.postModel ?? model;
    final fileList = _model.fileList;
    if (fileList != null && fileList.first != null) {
      final fileModel = fileList.first;
      if (fileModel.fileType == '1') {
        TKRoute.push(context, FindVideoList(_model.messageId));
        return;
      }
    }
    TKRoute.push(context, FindDetailPage(messageId: model.messageId, actionCallBack: (model) {
      _model.agreeStatus = model.agreeStatus;
      _model.cntAgree = model.cntAgree;
      _model.cntComment = int.parse(model.commentNum);
      _model.followStatus = model.followStatus;
      _model.commentList = model.commentList;
      itemVM.postModel = _model;
      if (_model.followStatus == '未关注') {
        actionCallback(FindActionType.detail);
      }
    }));
  }

  void jumpFindUserPage(BuildContext context, FindItemProvider itemVM) {
    final _model = itemVM.postModel ?? model;
    TKRoute.push(context, FindUserPage(userId: model.userId, actionCallBack: (followStatus) {
      _model.followStatus = followStatus;
      itemVM.postModel = _model;
      if (_model.followStatus == '未关注') {
        actionCallback(FindActionType.header);
      }
    }));
  }
}


