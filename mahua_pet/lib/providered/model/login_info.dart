import 'dart:convert';
import 'package:mahua_pet/providered/shared/shared_index.dart';


LoginInfo loginInfoFromJson(String str) => LoginInfo.fromJson(json.decode(str));

String loginInfoToJson(LoginInfo data) => json.encode(data.toJson());

class LoginInfo {
    LoginInfo({
        this.userId,
        this.userPhone,
        this.userPassword,
        this.userType,
        this.authStatus,
        this.userProperty,
        this.registerChannel,
        this.registerType,
        this.platformType,
        this.createTime,
        this.modifyTime,
        this.isFlag,
        this.delFlag,
        this.token,
        this.nickname,
        this.headImg,
        this.accid,
        this.accToken,
        this.hxPassword,
    });

    int userId;
    String userPhone;
    String userPassword;
    String userType;
    String authStatus;
    String userProperty;
    String registerChannel;
    String registerType;
    String platformType;
    DateTime createTime;
    DateTime modifyTime;
    String isFlag;
    String delFlag;
    String token;
    String nickname;
    String headImg;
    String accid;
    String accToken;
    String hxPassword;

  factory LoginInfo.fromJson(Map<String, dynamic> json) {

    SharedUtils.setInt(ShareConstant.userId, json['userId'] ?? 0);
    SharedUtils.setString(ShareConstant.token, json['token'] ?? '');
    SharedUtils.setString(ShareConstant.userPhone, json['userPhone'] ?? '');
    SharedUtils.setString(ShareConstant.userPassword, json['userPassword'] ?? '');
    SharedUtils.setString(ShareConstant.userType, json['userType'] ?? '');
    SharedUtils.setString(ShareConstant.authStatus, json['authStatus'] ?? '');
    SharedUtils.setString(ShareConstant.userProperty, json['userProperty'] ?? '');
    SharedUtils.setString(ShareConstant.registerChannel, json['registerChannel'] ?? '');
    SharedUtils.setString(ShareConstant.registerType, json['registerType'] ?? '');

    return LoginInfo(
      userId: json["userId"],
      userPhone: json["userPhone"],
      userPassword: json["userPassword"],
      userType: json["userType"],
      authStatus: json["authStatus"],
      userProperty: json["userProperty"],
      registerChannel: json["registerChannel"],
      registerType: json["registerType"],
      platformType: json["platformType"],
      createTime: DateTime.parse(json["createTime"]),
      modifyTime: DateTime.parse(json["modifyTime"]),
      isFlag: json["isFlag"],
      delFlag: json["delFlag"],
      token: json["token"],
      nickname: json["nickname"],
      headImg: json["headImg"],
      accid: json["accid"],
      accToken: json["accToken"],
      hxPassword: json["hxPassword"],
    );
  }

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userPhone": userPhone,
        "userPassword": userPassword,
        "userType": userType,
        "authStatus": authStatus,
        "userProperty": userProperty,
        "registerChannel": registerChannel,
        "registerType": registerType,
        "platformType": platformType,
        "createTime": createTime.toIso8601String(),
        "modifyTime": modifyTime.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
        "token": token,
        "nickname": nickname,
        "headImg": headImg,
        "accid": accid,
        "accToken": accToken,
        "hxPassword": hxPassword,
    };
}
