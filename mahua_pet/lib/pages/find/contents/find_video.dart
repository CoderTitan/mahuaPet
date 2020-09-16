import 'package:flutter/material.dart';
import 'package:mahua_pet/pages/find/view_model/find_request.dart';
import 'package:mahua_pet/pages/find/views/find_video_play.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:mahua_pet/styles/app_style.dart';

import '../models/model_index.dart';


class FindVideoList extends StatefulWidget {

  final int messageId;

  FindVideoList(int messageId): messageId = messageId;

  @override
  _FindVideoListState createState() => _FindVideoListState(messageId);
}

class _FindVideoListState extends State<FindVideoList> {

  final int messageId;

  _FindVideoListState(int messageId): messageId = messageId;

  int _currentIndex = 0;
  int _postPage = 1;
  FindVideoModel _currentModel;
  List<FindVideoModel> _videoArray = [];


  @override
  void initState() {
    super.initState();

    requestVideoList(1);
  }


  @override
   Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: renderChildList(context),
        ),
      ),
    );
  }

  List<Widget> renderChildList(BuildContext context) {
    if (_currentModel == null) { 
      return [Container(color: Colors.black)];
    }

    List<Widget> itemList = [
      renderCarouselSlider(),
      renderNavigation(context),
    ];
    
    return itemList;
  }

  Widget renderCarouselSlider() {
    return Container(
      color: Colors.black,
      child: CarouselSlider.builder(
        itemCount: _videoArray.length,
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          height: SizeFit.screenHeight,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) => onPageChanged(index)
        ),
        itemBuilder: (ctx, index) {
          if (_videoArray.length <= index) {
            return Container();
          }
          final model = _videoArray[index];
          return FindVideoPlay(
            key: ValueKey(index), 
            canPlay: index == _currentIndex, 
            videoModel: model, 
            actionCallback: (type) {
              
            }
          );
        },
      ),
    );
  }

  Widget renderNavigation(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.only(top: SizeFit.statusHeight),
        width: SizeFit.screenWidth,
        height: 44 + SizeFit.statusHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () {
              Navigator.of(context).pop();
            }),
            IconButton(icon: Icon(Icons.file_download, color: Colors.white), onPressed: () => _saveVideo(context)),
          ],
        ),
      ),
    );
  }

  void _saveVideo(BuildContext context) {
    TKMediaUtil.saveVideo(context, _currentModel.fileUrl);
  }
  

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentModel = _videoArray[index];
    });

    if (index == _videoArray.length - 2) {
      _postPage += 1;
      requestVideoList(_postPage);
    }
  }

  void requestVideoList(pageIndex) {
    FindRequest.requestVideoList(messageId, pageIndex).then((value) {
      if (pageIndex == 1) {
        _currentModel = value.first;
        _videoArray = value;
      } else {
        _videoArray.addAll(value);
      }
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }
}
