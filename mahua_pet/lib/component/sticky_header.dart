
/*
 * tabbar 吸顶效果
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final bool isNight;

  StickyTabBarDelegate({
    @required this.child,
    @required this.isNight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.px),
      color: isNight ? TKColor.black : TKColor.white,
      child: child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class StickyChildDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  StickyChildDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  bool shouldRebuild(StickyChildDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }
}
