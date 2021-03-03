import 'package:flutter/material.dart';

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation')),
      body: Center(
        child: PhotoHero(
          photo: 'https://titanjun.oss-cn-hangzhou.aliyuncs.com/ios/swift.jpg?x-oss-process=style/titanjun',
          width: 300,
          onTap: () {

          },
        ),
      ),
    );
  }

  void heroAnimatedTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) {
        return Scaffold(

        );
      }
    ));
  }
}


class PhotoShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Show')),
      body: PhotoHero(
        
      ),
    );
  }
}


class PhotoHero extends StatelessWidget {

  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo, 
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(photo, fit: BoxFit.contain),
          ),
        )
      ),
    );
  }
}