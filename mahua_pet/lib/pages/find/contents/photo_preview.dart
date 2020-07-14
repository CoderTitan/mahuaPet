import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';


class PhotoPreview extends StatefulWidget {

  final int index;
  final List<String> images;

  PhotoPreview({
    this.index = 0, 
    @required List<String> images
  }): images = images ?? [];

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState(index: index, images: images);
}

class _PhotoPreviewState extends State<PhotoPreview> {

  PageController _pageController;
  String _title = '';
  int _currentIndex = 0;
  final int index;
  final List<String> images;

  _PhotoPreviewState({this.index = 0, this.images}): 
    _title = images.length == 0 ? '' : '${index + 1}/${images.length}';


  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            renderPhotoView(context),
            renderNavigation(context),
            renderBottomBar(context)
          ],
        ),
      ),
    );
  }

  Widget renderPhotoView(BuildContext context) {
    return Container(
      width: SizeFit.screenWidth,
      height: SizeFit.screenHeight,
      child: PhotoViewGallery.builder(
        builder: (ctx, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.images[index]),
            initialScale: PhotoViewComputedScale.contained * 1,
          );
        },
        loadingBuilder: (ctx, event) {
          return Center(
            child: Container(
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            _title = '${index + 1}/${images.length}';
          });
        },
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: _pageController,
        itemCount: widget.images.length,
        loadFailedChild: Image.asset(TKImages.image_path + 'find_none_image.png'),
        backgroundDecoration: BoxDecoration(color: Colors.black),
        gaplessPlayback: false,
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
            Text(_title, style: TextStyle(fontSize: 18.px, color: Colors.white, fontWeight: FontWeight.w500)),
            IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.transparent), onPressed: null),
          ],
        ),
      ),
    );
  }

  Widget renderBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(bottom: SizeFit.safeHeight, right: 8.px),
        width: SizeFit.screenWidth,
        height: 44 + SizeFit.safeHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(icon: Icon(Icons.share, color: Colors.white), onPressed: () {

            }),
            IconButton(icon: Icon(Icons.file_download, color: Colors.white), onPressed: () {
              final image = images[_currentIndex] ?? '';
              TKMediaUtil.saveImage(context, image);
            }),
          ],
        ),
      ),
    );
  }

}