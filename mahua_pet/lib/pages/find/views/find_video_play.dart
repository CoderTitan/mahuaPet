import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/views/find_bottom_tool.dart';
import 'package:mahua_pet/pages/find/views/find_item_image.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:video_player/video_player.dart';

import '../models/model_index.dart';
import '../view_model/find_request.dart';

class FindVideoPlay extends StatefulWidget {

  final FindVideoModel videoModel;
  final bool canPlay;
  final FindActionCallBack actionCallback;

  FindVideoPlay({Key key, this.canPlay, this.videoModel, this.actionCallback}): super(key: key);

  @override
  _FindVideoPlayState createState() => _FindVideoPlayState();
}

class _FindVideoPlayState extends State<FindVideoPlay> {

  VideoPlayerController _videoController;
  FocusNode _focusNode = FocusNode();
  TextEditingController _editController = TextEditingController();


  bool _videoLoaded = false;
  bool _videoError = false;
  bool _isPlaying = true;
  int _currentTime = 0;
  int _totalTime = 1;



  @override
  void initState() {

    _videoController = VideoPlayerController.network(widget.videoModel.fileUrl);
    _videoController.setLooping(true);
    _videoController.addListener(_videoListener);
    _videoController.initialize().then((value) {
      _videoController.play();
      _totalTime = _videoController.value.duration.inSeconds;
      setState(() {});
    });

    super.initState();
  }

  @override
  void didUpdateWidget(FindVideoPlay oldWidget) {
    if (oldWidget.videoModel != widget.videoModel) {
      
    }
    _videoChanged();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {

    _videoController.dispose();
    _videoController.removeListener(_videoListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          renderVideoItem(),
          renderBottomBar(context)
        ],
      ),
    );
  }

  Widget renderVideoItem() {
    Widget videoItem = AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: VideoPlayer(_videoController),
    );

    Widget indicator = Stack(
      children: <Widget>[
        Image.network(widget.videoModel.videoCover, fit: BoxFit.contain, width: SizeFit.screenWidth, height: SizeFit.screenHeight),
        Center(child: CircularProgressIndicator())
      ],
    );

    return GestureDetector(
      child: Container(
        width: SizeFit.screenWidth,
        height: SizeFit.screenHeight,
        color: Colors.black,
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              _videoController.value.initialized ? videoItem : indicator,
              Positioned(
                child: _isPlaying ? Container() : Center(
                  child: Image.asset(TKImages.image_path + 'video_play.png', width: 55.px, height: 55.px)
                )
              )
            ],
          )
        ),
      ),
      onTap: () {
        if (_isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
    );
  }

  Widget renderBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.px, 0, 16.px, SizeFit.safeHeight),
        width: SizeFit.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black45, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            renderUserInfo(),
            renderMessage(),
            renderProgressItem(),
            renderBottomItem()
          ],
        ),
      ),
    );
  }

  Widget renderUserInfo() {
    return Row(
      children: <Widget>[
        FindItemImage(
          imageUrl: widget.videoModel.headImg,
          width: 30.px,
          height: 30.px,
          radius: 20.px,
          onPress: () {
            _videoController.pause();
            setState(() {
              _isPlaying = false;
            });
            widget.actionCallback(FindActionType.header);
          },
        ),
        SizedBox(width: 10.px),
        Text(widget.videoModel.nickName, style: TextStyle(fontSize: 16.px, color: TKColor.white))
      ],
    );
  }

  Widget renderMessage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: Text(widget.videoModel.messageInfo, style: TextStyle(fontSize: 14.px, color: TKColor.white)),
    );
  }

  Widget renderProgressItem() {
    return Row(
      children: <Widget>[
        Text(getTimer(_currentTime), style: TextStyle(fontSize: 12.px, color: TKColor.white)),
        SizedBox(width: 10.px),
        Expanded(
          child: Container(
            height: 2.px,
            child: LinearProgressIndicator(
              value: _currentTime / _totalTime,
              backgroundColor: Color(0x88FFFFFF),
              valueColor: AlwaysStoppedAnimation(TKColor.white),
            ),
          ),
        ),
        SizedBox(width: 10.px),
        Text(getTimer(_totalTime), style: TextStyle(fontSize: 12.px, color: TKColor.white)),
      ],
    );
  }

  Widget renderBottomItem() {
    return FindBottomTool(
      focusNode: _focusNode,
      controller: _editController,
      submitAction: (text) => {},
      agreeState: widget.videoModel.agreeStatus == '1',
      collectionState: widget.videoModel.collectionStatus == '1',
      agreeCount: '${widget.videoModel.cntAgree}',
      collectionCount: widget.videoModel.collectionNum,
      backcolorColor: Colors.transparent,
      showBorder: false,
      mainColor: TKColor.white,
      inputBackColor: Color(0x77FFFFFF),
      actionCallback: (type) {
        widget.actionCallback(type);
      },
    );
  }


  void _videoListener() {
    if (_videoController.value.hasError) {
      setState(() {
        _videoError = true;
        _videoLoaded = false;
      });
    } else {
      setState(() {
        _videoLoaded = true;
        _videoError = false;
        _currentTime = _videoController.value.position.inSeconds;
      });
    }
  }

  void _videoChanged() {
    if (widget.videoModel == null || widget.videoModel.fileUrl == null || widget.videoModel.fileUrl.length <= 0) {
      Navigator.of(context).pop();
      return;
    }
    if (_videoController != null) {
      _videoController.removeListener(_videoListener);
      _videoController.dispose();
    }

    _videoController = VideoPlayerController.network(widget.videoModel.fileUrl);
    _videoController.setLooping(true);
    _videoController.addListener(_videoListener);
    _videoController.initialize().then((value) {
      _videoController.play();
      _totalTime = _videoController.value.duration.inSeconds;
      setState(() {});
    });
  }

  String getTimer(int duration) {
    final int time = duration ?? 0;
    final minute = time ~/ 60;
    final secord = time % 60;

    final minuteStr = minute > 9 ? '$minute' : '0$minute';
    final secordStr = secord > 9 ? '$secord' : '0$secord';

    return '$minuteStr:$secordStr';
  }


  // 动态列表--关注
  void requestPostAttation(FocusPostModel model) {
    TKToast.showLoading();
    FindRequest.requestFocus(model.followStatus == '关注', model.userId)
      .then((value) {
        if (value) {
          if (model.followStatus != '关注') {
            TKToast.showSuccess('关注成功');
          } else {
            TKToast.showSuccess('取消关注成功');
          }
        }
      }).catchError((error) {
        TKToast.dismiss();
        print(error);
      });
  }

  // 点赞
  void requestAgreeState(FocusPostModel model) {
    TKToast.showLoading();
    FindRequest.requestAgree(model.agreeStatus == '0', messageId: model.messageId).then((value) {
      if (value) {
        if (model.agreeStatus == '0') {
          model.cntAgree = model.cntAgree + 1;
          TKToast.showSuccess('点赞成功');
        } else {
          model.cntAgree = model.cntAgree - 1;
          TKToast.showSuccess('取消点赞成功');
        }
        // _postArray.forEach((element) {
        //   if (element.userId == model.userId) {
        //     element.agreeStatus = model.agreeStatus == '0' ? '1' : '0';
        //   }
        // });
        setState(() { });
      }
    }).catchError((error) {
      TKToast.dismiss();
      print(error);
    });
  }

  // 收藏
  void requestCollectState() {
    TKToast.showLoading();
    // FindRequest.requestCollection(_model.collectionsStatus == '0', _model.messageId).then((value) {
    //   if (value) {
    //     if (_model.collectionsStatus == '0') {
    //       _model.collectionNum = '${int.parse(_model.collectionNum) + 1}';
    //       TKToast.showSuccess('收藏成功');
    //     } else {
    //       _model.collectionNum = '${int.parse(_model.collectionNum) - 1}';
    //       TKToast.showSuccess('取消收藏成功');
    //     }
    //     _model.collectionsStatus = _model.collectionsStatus == '0' ? '1' : '0';
    //     setState(() { });
    //   }
    // }).catchError((error) {
    //   TKToast.dismiss();
    //   print(error);
    // });
  }

  // 评论内容
  void postComment(String message) {
    if (message == null || message.isEmpty) {
      TKToast.showToast('内容不能为空');
      return;
    }
    TKToast.showLoading();
    // FindRequest.requestComment(message, _model.messageId).then((value) {
      
    //   if (value) {
    //     _editController.text = '';
    //     _onRefresh();
    //   }
    // }).catchError((error) {
    //   TKToast.dismiss();
    //   print(error);
    // });
  }

  // 评论内容
  void replyComment(String message) {
    if (message == null || message.isEmpty) {
      TKToast.showToast('内容不能为空');
      return;
    }
    TKToast.showLoading();
    // FindRequest.replyComment(message, _currentComment.commentId, _currentComment.userId).then((value) {
    //   if (value) {
    //     _editController.text = '';
    //     _onRefresh();
    //   }
    // }).catchError((error) {
    //   TKToast.dismiss();
    //   print(error);
    // });
  }

  // 删除评论内容
  void deleteComment() {
    TKToast.showLoading();
    // FindRequest.deleteComment(_currentComment.commentId).then((value) {
    //   if (value) {
        
    //     List<CommentModel> newModels = _commentList.where((element) => element.commentId != _currentComment.commentId).toList();
    //     setState(() { 
    //       _commentList = newModels;
    //     });
    //   }
    // }).catchError((error) {
    //   TKToast.dismiss();
    //   print(error);
    // });
  }
}