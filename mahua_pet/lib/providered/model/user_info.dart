// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';


UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    UserInfo({
        this.userinfoId,
        this.userId,
        this.accid,
        this.accToken,
        this.hxPassword,
        this.headImg,
        this.nickname,
        this.sex,
        this.intro,
        this.coin,
        this.accountBalance,
        this.province,
        this.city,
        this.deviceNo,
        this.inviteCode,
        this.starRankId,
        this.starRank,
        this.starRankName,
        this.starValue,
        this.chainPrivateKey,
        this.chainPublicKey,
        this.chainAddress,
        this.talentType,
        this.isRecommend,
        this.imei,
        this.createTime,
        this.modifyTime,
        this.isFlag,
        this.delFlag,
    });

    int userinfoId;
    int userId;
    String accid;
    String accToken;
    String hxPassword;
    String headImg;
    String nickname;
    String sex;
    String intro;
    int coin;
    double accountBalance;
    String province;
    String city;
    String deviceNo;
    String inviteCode;
    int starRankId;
    int starRank;
    String starRankName;
    int starValue;
    String chainPrivateKey;
    String chainPublicKey;
    String chainAddress;
    String talentType;
    String isRecommend;
    String imei;
    DateTime createTime;
    DateTime modifyTime;
    String isFlag;
    String delFlag;

    factory UserInfo.fromJson(Map<String, dynamic> json) {

      return UserInfo(
        userinfoId: json["userinfoId"],
        userId: json["userId"],
        accid: json["accid"],
        accToken: json["accToken"],
        hxPassword: json["hxPassword"],
        headImg: json["headImg"] ?? '',
        nickname: json["nickname"] ?? '',
        sex: json["sex"] ?? '',
        intro: json["intro"] ?? '',
        coin: json["coin"],
        accountBalance: json["accountBalance"],
        province: json["province"],
        city: json["city"] ?? '',
        deviceNo: json["deviceNo"],
        inviteCode: json["inviteCode"],
        starRankId: json["starRankId"],
        starRank: json["starRank"],
        starRankName: json["starRankName"],
        starValue: json["starValue"],
        chainPrivateKey: json["chainPrivateKey"],
        chainPublicKey: json["chainPublicKey"],
        chainAddress: json["chainAddress"],
        talentType: json["talentType"],
        isRecommend: json["isRecommend"],
        imei: json["imei"],
        createTime: DateTime.parse(json["createTime"]),
        modifyTime: DateTime.parse(json["modifyTime"]),
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
      );
    }

    Map<String, dynamic> toJson() => {
        "userinfoId": userinfoId,
        "userId": userId,
        "accid": accid,
        "accToken": accToken,
        "hxPassword": hxPassword,
        "headImg": headImg,
        "nickname": nickname,
        "coin": coin,
        "accountBalance": accountBalance,
        "province": province,
        "city": city,
        "deviceNo": deviceNo,
        "inviteCode": inviteCode,
        "starRankId": starRankId,
        "starRank": starRank,
        "starRankName": starRankName,
        "starValue": starValue,
        "chainPrivateKey": chainPrivateKey,
        "chainPublicKey": chainPublicKey,
        "chainAddress": chainAddress,
        "talentType": talentType,
        "isRecommend": isRecommend,
        "imei": imei,
        "createTime": createTime?.toIso8601String(),
        "modifyTime": modifyTime?.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}

