import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonList extends StatelessWidget {

  /// 需要展示的个数, 充满屏幕即可
  final int count;
  final EdgeInsetsGeometry padding;
  final IndexedWidgetBuilder builder;

  SkeletonList({
    this.padding = const EdgeInsets.all(8),
    this.count = 6,
    @required this.builder
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 1500),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Padding(
          padding: padding,
          child: Column(
            children: List.generate(count, (index) => builder(context, index)),
          ),
        ), 
      ),
    );
  }
}


class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;

  SkeletonContainer({
    @required this.width, 
    @required this.height, 
    this.isCircle = false
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Divider.createBorderSide(context, width: 0.5);
    return Container(
      width: width,
      height: height,
      decoration: SkeletonDecoration(isCircle: isCircle, isDark: isDark),
    );
  }
}


class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    isCircle = false,
    isDark = false,
  }): super(
    color: !isDark ? Colors.grey[350] : Colors.grey[700],
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
  );
}