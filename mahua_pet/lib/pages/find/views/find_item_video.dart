import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:video_player/video_player.dart';

class FindVideoItem extends StatefulWidget {

  final String videoURL;

  FindVideoItem({Key key, this.videoURL}): super(key: key);

  @override
  _FindVideoItemState createState() => _FindVideoItemState();
}

class _FindVideoItemState extends State<FindVideoItem> {

  VideoPlayerController _videoController;

  @override
  void initState() {    
    super.initState();

    _videoController = VideoPlayerController.network(widget.videoURL)..initialize().then((value) {
      _videoController.pause();
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(FindVideoItem oldWidget) {
    if (oldWidget.videoURL != widget.videoURL) {
      _videoChanged();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();

    _videoController.dispose();
  }

  void _videoChanged() {
    if (widget.videoURL == null || widget.videoURL.length <= 0) {
      Navigator.of(context).pop();
      return;
    }
    if (_videoController != null) {
      _videoController.dispose();
    }

    _videoController = VideoPlayerController.network(widget.videoURL)
    ..initialize().then((value) {
      _videoController.pause();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeFit.screenWidth / 3 * 2,
      height: (SizeFit.screenWidth / 3 * 2) / 16 * 9,
      margin: EdgeInsets.only(top: 8.px),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Stack(children: renderVideoItem()),
    );
  }

  List<Widget> renderVideoItem() {
    List<Widget> itemList = [];

    final isInitial = _videoController.value.initialized;
    if (isInitial) {
      Widget playerItem = Center(
        child: AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
      );
      itemList.add(playerItem);

      Widget pauseItem = Positioned(child: Center(child: Image.asset(TKImages.image_path + 'video_play.png', width: 55.px, height: 55.px)));
      itemList.add(pauseItem);
    } else {
      Widget loading = Center(child: CircularProgressIndicator());
      itemList.add(loading);
    }

    return itemList;
  }
}