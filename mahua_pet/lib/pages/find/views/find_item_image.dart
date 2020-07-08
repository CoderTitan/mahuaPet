import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/styles/app_images.dart';

class FindItemImage extends StatelessWidget {

  final String imageUrl;
  final double width;
  final double height;
  final double radius;
  final GestureTapCallback onPress;

  FindItemImage({
    Key key,
    @required this.imageUrl,
    this.width,
    this.height,
    this.radius = 5,
    this.onPress
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TKNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        borderRadius: radius,
        fit: BoxFit.cover,
        placeholder: TKImages.image_path + 'find_none_image.png',
      ),
      onTap: () {
        onPress();
      },
    );
  }
}