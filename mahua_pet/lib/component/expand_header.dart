/*
 * 下拉视图放大
 */


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahua_pet/styles/app_style.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {

  final Widget child;
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String title;
  final IconData trailing;
  final VoidCallback trailingPress;
  
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.child,
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.title,
    this.trailing,
    this.trailingPress
  });

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if(shrinkOffset > 50 && statusBarMode == 'dark') {
      statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if(shrinkOffset <= 50 && statusBarMode == 'light') {
      statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 245, 202, 43);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: maxExtent,
      width: SizeFit.screenWidth,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: child, height: maxExtent,
      width: SizeFit.screenWidth,),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.w500,
                          color: makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          trailing,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: trailingPress == null ? null : () {
                          trailingPress();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class SliverScaleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverScaleHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  bool shouldRebuild(SliverScaleHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }
}