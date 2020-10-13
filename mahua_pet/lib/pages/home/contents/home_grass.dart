import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';

import '../models/grass_model.dart';
import '../views/home_grid_item.dart';
import '../request/home_request.dart';


class HomeGressContent extends StatefulWidget {
  @override
  _HomeGressContentState createState() => _HomeGressContentState();
}

class _HomeGressContentState extends State<HomeGressContent> {

  List<GrassModel> modelList;
  int pageIndex = 1;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Container(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 8.px,
            crossAxisSpacing: 8.px,
            itemCount: modelList.length,
            staggeredTileBuilder: (_) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return HomeGridItem(key: ValueKey(index), model: modelList[index]);
            },
          ),
        );
      },
    );
  }

  void refreshData({void Function(bool success, bool more) completed}) {
    requestGrass(1, completed: completed);
  }

  void loadMoreData({void Function(bool success, bool more) completed}) {
    if (showLoading) {
      TKToast.showLoading();
    }
    showLoading = true;
    pageIndex += 1;
    requestGrass(pageIndex, completed: completed);
  }

  void requestGrass(int pageIndex, {void Function(bool success, bool more) completed}) {
    HomeRequest.requestHomeGrass(pageIndex).then((value) {
      TKToast.dismiss();
      showLoading = false;
      List<GrassModel> models = value ?? [];
      if (pageIndex == 1) {
        modelList = models;
      } else {
        modelList.addAll(models);
      }
      setState(() {});

      var hasMoreData = false;
      if (models.length > 10) {
        hasMoreData = true;
      }
      completed(true, hasMoreData);
    }).catchError((error) {
      TKToast.dismiss();
      showLoading = false;
      completed(false, false);
    }); 
  }
}