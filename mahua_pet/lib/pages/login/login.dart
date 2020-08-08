
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/login/password_login.dart';
import 'package:mahua_pet/providered/provider_index.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'views/login_input.dart';


class LoginPage extends StatelessWidget {

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        elevation: 0,
      ),
      body: Container(
         height: double.infinity,
        child: Stack(
          children: <Widget>[
            Image.asset(
              '${TKImages.image_path}login_logo.png', 
              width: SizeFit.screenWidth, 
              height: 155.px, 
              fit: BoxFit.contain
            ),
            LoginContent()
          ],
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  FocusNode _accountNode = new FocusNode();
  FocusNode _codeNode = new FocusNode();

  final GlobalKey<AuthCodeButtonState> authCodeKey = GlobalKey();

  bool _disabled = false;
  String _account = '';
  String _code = '';

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 105.px,
      child: Container(
        decoration: BoxDecoration(
          color: TKColor.color_f7f7f7,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.px),
            topRight: Radius.circular(25.px),
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 18.px),
            accountWidget(),
            SizedBox(height: 10.px),
            codeWidget(),
            SizedBox(height: 15.px),
            registerWidget(context),
            SizedBox(height: 30.px),
            loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget accountWidget() {
    return LoginInput(
      leftTitle: '手机号',
      keyboardType: TextInputType.number,
      controller: _accountController,
      focusNode: _accountNode,
      maxLength: 11,
      autofocus: true,
      placeText: '请输入手机号',
      onChanged: (text) {
        _account = text;
        updateLoginState();
      },
    );
  }

  Widget codeWidget() {
    return LoginInput(
      leftTitle: '验证码',
      keyboardType: TextInputType.number,
      controller: _codeController,
      focusNode: _codeNode,
      maxLength: 6,
      placeText: '请输入验证码',
      suffix: codeButtonWidget(),
      onChanged: (text) {
        _code = text;
        updateLoginState();
      },
    );
  }

  void updateLoginState() {
    final isDisable = _account.length == 11 && _code.length >= 4;
    setState(() {
      _disabled = isDisable;
    });
  }

  Widget codeButtonWidget() {
    return AuthCodeButton(
      key: authCodeKey,
      timeCount: 60,
      onPressed: () {
        final isPhone = FuncUtils.isPhoneNumber(_account);
        if (!isPhone) {
          TKToast.showWarn('请输入正确手机号');
          return;
        }

        getCodeAction();
      }
    );
  }

  Widget registerWidget(BuildContext context) {
    final routeName = ModalRoute.of(context).settings.arguments;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Text('账号密码登录', style: TextStyle(fontSize: 13.px, color: TKColor.main_color)),
              onTap: () {
                Navigator.of(context).pushNamed(PasswordPage.routeName, arguments: routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return LargeButton(
      title: '登录',
      disabled: _disabled,
      onPressed: () {
        loginAction(context);
      }
    );
  }

  void getCodeAction() {

    // final phone = '%7B%22phone%22%3A%2213456789417%22,%22time%22%3A%221593436035612%22,%22sign%22%3A%2288F2127F942900F5199A43BC0042C195%22%7D';
    // Utf8Decoder()




    TKToast.showLoading();
    TKRequest.requestData(HttpConfig.sendCode, method: 'get', params: {'phone': _account})
      .then((result) {
        if (result.isSuccess) {
          TKToast.showSuccess('验证码已发送');
          authCodeKey.currentState.startAction();
        } else {
          TKToast.showError(result.message);
        }
      })
      .catchError((error) {
        TKToast.dismiss();
        print('object = $error');
      });
  }

  void loginAction(BuildContext context) {
    TKToast.showLoading();
    final params = {'username': _account, 'code': _code, 'type': 'code', 'token': ''};

    TKRequest.requestData(HttpConfig.applogin, method: 'post', params: params)
      .then((value) {
        if (value.isSuccess) {
          Map<String, dynamic> result = value.data;
          UserProvider userModel = Provider.of<UserProvider>(context, listen: false);
          userModel.loginInfo = LoginInfo.fromJson(result);
          UserProvider.config('APP首页', userModel.loginInfo.token, userModel.loginInfo.userId);
          UserProvider.user(userModel.loginInfo.userId);
          TKRoute.popToRoutePage(context);
          TKToast.showSuccess('登录成功');
        } else {
          TKToast.showError(value.message);
        }
      })
      .catchError((error) {
        TKToast.dismiss();
      });
  }
}