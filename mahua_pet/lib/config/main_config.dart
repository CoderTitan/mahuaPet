
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mahua_pet/providered/provider/provider_config.dart';

class TKMainConfig extends StatelessWidget {

  final Widget child;
  TKMainConfig({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderConfig.providers,
      child: RefreshConfiguration(
        headerTriggerDistance: 100,
        springDescription: SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
          enableScrollWhenRefreshCompleted: true, 
          enableLoadingWhenFailed : true, 
          hideFooterWhenNotFull: false,
          enableBallisticLoad: true, 
        headerBuilder: () => ClassicHeader(
          height: 50,
          refreshStyle: RefreshStyle.UnFollow,
          refreshingText: '正在刷新中...',
          releaseText: '松开立即刷新',
          completeText: '数据加载完成',
          idleText: '下拉开始刷新',
          failedText: '数据加载失败',
          releaseIcon: Icon(Icons.arrow_downward, color: Colors.grey),
        ),
        footerBuilder: () => ClassicFooter(
          height: 50,
          loadingText: '正在加载中...',
          canLoadingText: '松开立即加载',
          noDataText: '没有更多数据了',
          idleText: '上拉开始加载',
          failedText: '数据加载失败',
          loadingIcon: CupertinoActivityIndicator(),
          canLoadingIcon: Icon(Icons.arrow_upward, color: Colors.grey),
        ),
        child: child,
      ),
    );
  }
}
