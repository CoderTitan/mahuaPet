import 'dart:convert';


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
        this.isFlag,
        this.delFlag,
        this.token,
        this.nickname,
        this.headImg,
        this.accid,
        this.accToken,
        this.hxPassword,
    });

    // 最后一位登录的用户的userId
    int lastUserId = 0;

    int userId;
    String userPhone;
    String userPassword;
    String userType;
    String authStatus;
    String userProperty;
    String registerChannel;
    String registerType;
    String platformType;
    String isFlag;
    String delFlag;
    String token;
    String nickname;
    String headImg;
    String accid;
    String accToken;
    String hxPassword;

  factory LoginInfo.fromJson(Map<String, dynamic> json) {

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
