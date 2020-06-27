// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';
import 'package:mahua_pet/providered/shared/shared_index.dart';

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
    int coin;
    int accountBalance;
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

      // 缓存用户信息数据
      SharedUtils.setInt(ShareConstant.userId, json['userId'] ?? 0);
      SharedUtils.setString(ShareConstant.accid, json['accid'] ?? '');
      SharedUtils.setString(ShareConstant.accToken, json['accToken'] ?? '');
      SharedUtils.setString(ShareConstant.hxPassword, json['hxPassword'] ?? '');
      SharedUtils.setString(ShareConstant.headImg, json['headImg'] ?? '');
      SharedUtils.setString(ShareConstant.nickname, json['nickname'] ?? '');
      SharedUtils.setInt(ShareConstant.coin, json['coin'] ?? 0);
      SharedUtils.setInt(ShareConstant.accountBalance, json['accountBalance'] ?? 0);
      SharedUtils.setString(ShareConstant.inviteCode, json['inviteCode'] ?? '');
      SharedUtils.setInt(ShareConstant.starRankId, json['starRankId'] ?? 0);
      SharedUtils.setInt(ShareConstant.starRank, json['starRank'] ?? 0);
      SharedUtils.setString(ShareConstant.starRankName, json['starRankName'] ?? '');
      SharedUtils.setInt(ShareConstant.starValue, json['starValue'] ?? 0);
      SharedUtils.setString(ShareConstant.chainPrivateKey, json['chainPrivateKey'] ?? '');
      SharedUtils.setString(ShareConstant.chainPublicKey, json['chainPublicKey'] ?? '');
      SharedUtils.setString(ShareConstant.chainAddress, json['chainAddress'] ?? '');
      SharedUtils.setString(ShareConstant.talentType, json['talentType'] ?? '');
      SharedUtils.setString(ShareConstant.isRecommend, json['isRecommend'] ?? '');

      return UserInfo(
        userinfoId: json["userinfoId"],
        userId: json["userId"],
        accid: json["accid"],
        accToken: json["accToken"],
        hxPassword: json["hxPassword"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        coin: json["coin"],
        accountBalance: json["accountBalance"],
        province: json["province"],
        city: json["city"],
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

    factory UserInfo.cleanShared() {
      // 清除缓存的用户信息数据
      SharedUtils.setInt(ShareConstant.userId, 0);
      SharedUtils.setString(ShareConstant.accid, '');
      SharedUtils.setString(ShareConstant.accToken, '');
      SharedUtils.setString(ShareConstant.hxPassword, '');
      SharedUtils.setString(ShareConstant.headImg, '');
      SharedUtils.setString(ShareConstant.nickname, '');
      SharedUtils.setInt(ShareConstant.coin, 0);
      SharedUtils.setInt(ShareConstant.accountBalance, 0);
      SharedUtils.setString(ShareConstant.inviteCode, '');
      SharedUtils.setInt(ShareConstant.starRankId, 0);
      SharedUtils.setInt(ShareConstant.starRank, 0);
      SharedUtils.setString(ShareConstant.starRankName, '');
      SharedUtils.setInt(ShareConstant.starValue, 0);
      SharedUtils.setString(ShareConstant.chainPrivateKey, '');
      SharedUtils.setString(ShareConstant.chainPublicKey, '');
      SharedUtils.setString(ShareConstant.chainAddress, '');
      SharedUtils.setString(ShareConstant.talentType, '');
      SharedUtils.setString(ShareConstant.isRecommend, '');

      return UserInfo();
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
        "createTime": createTime.toIso8601String(),
        "modifyTime": modifyTime.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}

