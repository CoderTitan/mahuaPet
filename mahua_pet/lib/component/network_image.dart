
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahua_pet/styles/app_images.dart';

class TKNetworkImage extends StatelessWidget {

  final String imageUrl;
  final ImageWidgetBuilder imageBuilder;
  final String placeholder;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final double boxRadius;
  final double borderWidth;
  final Color borderColor;
  final bool showProgress;


  TKNetworkImage({
    Key key,
    @required String imageUrl,
    this.imageBuilder,
    this.placeholder = TKImages.image_empty,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.boxRadius = 4,
    this.borderWidth = 0.0,
    this.borderColor = const Color(0x00000000),
    this.showProgress = false,
  }): imageUrl = imageUrl ?? '', super(key: key);


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 300),
      imageBuilder: imageBuilder == null ? (ctx, imageProvide) {
        return renderImage(imageProvide);
      } : imageBuilder,
      placeholder: (ctx, url) => renderPlaceHolder(),
      errorWidget: (ctx, url, error) => renderError(),
      // progressIndicatorBuilder: (context, url, downloadProgress) {
      //   return showProgress ? Center(
      //     child: CircularProgressIndicator(value: downloadProgress.progress),
      //   ) : null;
      // },
    );
  }

  Widget renderImage(ImageProvider image) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: fit
        ),
        borderRadius: borderRadius == null ? BorderRadius.circular(boxRadius) : borderRadius,
        border: Border.all(
          width: borderWidth,
          color: borderColor
        )
      ),
    );
  }

  
  Widget renderPlaceHolder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius == null ? BorderRadius.circular(boxRadius) : borderRadius,
        border: Border.all(
          width: borderWidth,
          color: borderColor
        )
      ),
      child: placeholder.length > 0 ?
      Stack(
        children: <Widget>[
          Image.asset(placeholder, width: width, height: height, fit: BoxFit.cover),
          Positioned(child: Center(child: CupertinoActivityIndicator(radius: min(12, width / 3))))
        ],
      ) :
      CupertinoActivityIndicator(radius: min(16, width / 3))
    );
  }

  Widget renderError() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(placeholder),
          fit: fit
        ),
        borderRadius: borderRadius == null ? BorderRadius.circular(boxRadius) : borderRadius,
        border: Border.all(
          width: borderWidth,
          color: borderColor
        )
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: placeholder.length > 0 ?
      Container()
      :
      Icon(Icons.error, size: width > height ? height : width, color: Colors.black38)
    );
  }
}

