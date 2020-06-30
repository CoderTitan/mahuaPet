
import 'package:flutter/material.dart';
import 'package:mahua_pet/providered/model/model_index.dart';
import 'package:provider/provider.dart';


import 'package:mahua_pet/component/component.dart';
import 'package:mahua_pet/config/config_index.dart';
import 'package:mahua_pet/pages/login/register.dart';
import 'package:mahua_pet/providered/provider_index.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'views/login_input.dart';


class PasswordPage extends StatelessWidget {

  static const routeName = '/psd_login';

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
            PasswordContent()
          ],
        ),
      ),
    );
  }
}

class PasswordContent extends StatefulWidget {
  @override
  _PasswordContentState createState() => _PasswordContentState();
}

class _PasswordContentState extends State<PasswordContent> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _accountNode = new FocusNode();
  FocusNode _passwordNode = new FocusNode();

  bool _disabled = false;
  String _account = '';
  String _password = '';

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
            passwordWidget(),
            SizedBox(height: 15.px),
            registerWidget(),
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

  Widget passwordWidget() {
    return LoginInput(
      leftTitle: '密码',
      keyboardType: TextInputType.url,
      controller: _passwordController,
      focusNode: _passwordNode,
      maxLength: 20,
      showObscure: true,
      placeText: '请输入密码',
      onChanged: (text) {
        _password = text;
        updateLoginState();
      },
    );
  }

  void updateLoginState() {
    final isDisable = _account.length == 11 && _password.length >= 6 && _password.length <= 20;
    setState(() {
      _disabled = isDisable;
    });
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
              child: Text('验证码登录', style: TextStyle(fontSize: 13.px, color: TKColor.main_color)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            GestureDetector(
              child: Text('忘记密码', style: TextStyle(fontSize: 13.px, color: TKColor.main_color)),
              onTap: () {
                Navigator.of(context).pushNamed(RegisterPage.routeName);
              },
            )
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

  void loginAction(BuildContext context) {
    TKToast.showLoading();
    final params = {'username': _account, 'password': _password, 'type': 'password', 'token': ''};
    HttpRequest.request(HttpConfig.applogin, method: 'post', params: params)
      .then((value) {
        TKToast.dismiss();
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