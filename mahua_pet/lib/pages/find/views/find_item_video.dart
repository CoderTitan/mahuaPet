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

    _videoController = VideoPlayerController.network(widget.videoURL);
    _videoController.initialize().then((value) {
      _videoController.pause();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget playerItem = Center(
      child: AspectRatio(
        aspectRatio: _videoController.value.aspectRatio,
        child: VideoPlayer(_videoController),
      ),
    );
    return Container(
      width: 230.px,
      height: 310.px,
      margin: EdgeInsets.only(top: 8.px),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Stack(
        children: <Widget>[
          _videoController.value.initialized ? playerItem : Center(child: CircularProgressIndicator()),
          Positioned(child: Center(child: Image.asset(TKImages.image_path + 'video_play.png', width: 55.px, height: 55.px)))
        ],
      ),
    );
  }
}