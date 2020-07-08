
import 'package:flutter/material.dart';
import 'package:mahua_pet/styles/app_style.dart';
import '../views/find_item.dart';

class FindNearbyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 16.px),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                return Container();
              },
              childCount: 0,
            ),
          ),
        )
      ],
    );
  }
}