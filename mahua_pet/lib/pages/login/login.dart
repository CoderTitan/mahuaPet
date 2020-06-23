
import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/pages/login/password_login.dart';
import 'package:mahua_pet/pages/login/register.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/untils/untils.dart';
import 'views/login_input.dart';


class LoginPage extends StatelessWidget {

  static const rooteName = '/login';

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
            registerWidget(),
            SizedBox(height: 30.px),
            loginButton(),
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
      timeCount: 6,
      onPressed: () {
        final isPhone = FuncUntils.isPhoneNumber(_account);
        if (!isPhone) {
          print('请输入正确手机号');
          return;
        }
        authCodeKey.currentState.startAction();
        print('开始获取验证码');
      }
    );
  }

  Widget registerWidget() {
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
                Navigator.of(context).pushNamed(PasswordPage.rooteName);
              },
            ),
            GestureDetector(
              child: Text('注册', style: TextStyle(fontSize: 13.px, color: TKColor.main_color)),
              onTap: () {
                Navigator.of(context).pushNamed(RegisterPage.rooteName);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return LargeButton(
      title: '登录',
      disabled: _disabled,
      onPressed: () {
        loginAction();
        print('object---------------');
      }
    );
  }

  void loginAction() {
    
  }
}