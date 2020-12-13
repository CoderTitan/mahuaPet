import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';


class LaunchPage extends StatefulWidget {
  static final String routerName = "launch";

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  bool hadInit = false;
  int currentTime = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hadInit) return;
    hadInit = true;

    Store<TKState> store = StoreProvider.of(context);
    Future.delayed(const Duration(seconds: 3), () {
      SharedStorage.initUserInfo(store).then((result) {
        FetchUserInfoAction.loadPetList(store);
        TKRoute.pushMainRoot(context);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Material(
          child: Container(
            child: Stack(
              children: [
                Image.asset(TKImages.asset('launch_image'), fit: BoxFit.cover),
                Positioned(
                  bottom: SizeFit.safeHeight + 16.px,
                  right: 16.px,
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      child: Text('跳过 $currentTime', style: TextStyle(fontSize: 14.px, color: TKColor.white)),
                    ),
                    onTap: () {
                      SharedStorage.initUserInfo(store).then((result) {
                        TKRoute.pushMainRoot(context);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}