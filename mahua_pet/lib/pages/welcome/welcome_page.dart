import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mahua_pet/redux/redux_index.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/caches/caches_index.dart';
import 'package:mahua_pet/utils/utils_index.dart';


class WelcomePage extends StatefulWidget {
  static final String routerName = "welcome";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  PageController _pageController = PageController();
  List<String> imageList = [TKImages.asset('guideX1')];

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hadInit) return;
    hadInit = true;
  }


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<TKState>(
      builder: (ctx, store) {
        return Material(
          child: PageView(
            controller: _pageController,
            children: [1, 2, 3, 4].map((e) {
              return GestureDetector(
                child: Image.asset(TKImages.asset('guideX$e'), fit: BoxFit.cover),
                onTap: () {
                  if (e == 4) {
                    SharedStorage.saveShowWelcome();
                    SharedStorage.initUserInfo(store).then((result) {
                      if (FuncUtils.isLogin()) {
                        FetchUserInfoAction.loadPetList(store);
                      }
                      TKRoute.pushMainRoot(context);
                    });
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}