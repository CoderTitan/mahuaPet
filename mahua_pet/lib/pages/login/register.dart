
import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';

import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/utils/utils_index.dart';
import 'views/login_input.dart';


class RegisterPage extends StatelessWidget {

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
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
            RegisterContent()
          ],
        ),
      ),
    );
  }
}

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {

  TextEditingController _accountController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _accountNode = new FocusNode();
  FocusNode _codeNode = new FocusNode();
  FocusNode _passwordNode = new FocusNode();

  // final GlobalKey<_AuthCodeButtonState> authCodeKey = GlobalKey();

  bool _disabled = false;
  bool _isAgree = false;
  String _account = '';
  String _code = '';
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
            codeWidget(),
            SizedBox(height: 10.px),
            passwordWidget(),
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

  Widget passwordWidget() {
    return LoginInput(
      leftTitle: '密码',
      keyboardType: TextInputType.url,
      controller: _passwordController,
      focusNode: _passwordNode,
      maxLength: 20,
      showObscure: true,
      placeText: '请输入手密码',
      onChanged: (text) {
        _password = text;
        updateLoginState();
      },
    );
  }

  Widget codeButtonWidget() {
    return AuthCodeButton(
      timeCount: 6,
      onPressed: () {
        final isPhone = FuncUtils.isPhoneNumber(_account);
        if (!isPhone) {
          print('请输入正确手机号');
          return;
        }

        print('开始获取验证码');
      }
    );
  }

  Widget registerWidget() {
    final imageAsset = _isAgree ? '${TKImages.image_path}login_agree.png' : '${TKImages.image_path}login_agree_un.png';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Container(
        width: SizeFit.screenWidth - 30.px,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Image.asset(imageAsset, width: 15.px, height: 15.px, fit: BoxFit.contain),
              onTap: () {
                setState(() {
                  _isAgree = !_isAgree;
                });
              },
            ),
            SizedBox(width: 4.px),
            Text('同意', style: TextStyle(fontSize: 13.px, color: TKColor.color_cccccc)),
            GestureDetector(
              child: Text('《用户注册及隐私协议》', style: TextStyle(fontSize: 13.px, color: TKColor.main_color)),
              onTap: () {
                
              },
            )
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return LargeButton(
      title: '注册',
      disabled: _disabled,
      onPressed: () {
        print('object---------------');
      }
    );
  }

  void updateLoginState() {
    final isDisable = _account.length == 11 && _code.length >= 4 && _password.length > 6 && _password.length <= 20 && _isAgree;
    setState(() {
      _disabled = isDisable;
    });
  }

  VoidCallback loginAction() {
    return () {
      
    };
  }
}