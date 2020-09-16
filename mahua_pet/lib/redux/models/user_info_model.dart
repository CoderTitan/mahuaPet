// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    UserInfoModel({
        this.user,
        this.userinfo,
        this.userlevel,
        this.usermedalList,
        this.petCount,
        this.messageCount,
        this.fansCount,
        this.followCount,
        this.agreeCount,
        this.isSelf,
        this.followStatus,
        this.totalWalkDogTime,
        this.targetRule,
        this.fansNotifyStatus,
        this.deviceStatus,
        this.userMember,
        this.tribeFirstStatus,
        this.validCouponCount,
    });

    User user;
    Userinfo userinfo;
    Userlevel userlevel;
    List<dynamic> usermedalList;
    int petCount;
    int messageCount;
    int fansCount;
    int followCount;
    int agreeCount;
    String isSelf;
    String followStatus;
    String totalWalkDogTime;
    TargetRule targetRule;
    String fansNotifyStatus;
    bool deviceStatus;
    UserMember userMember;
    bool tribeFirstStatus;
    int validCouponCount;

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        user: User.fromJson(json["user"]),
        userinfo: Userinfo.fromJson(json["userinfo"]),
        userlevel: Userlevel.fromJson(json["userlevel"]),
        usermedalList: List<dynamic>.from(json["usermedalList"].map((x) => x)),
        petCount: json["petCount"],
        messageCount: json["messageCount"],
        fansCount: json["fansCount"],
        followCount: json["followCount"],
        agreeCount: json["agreeCount"],
        isSelf: json["isSelf"],
        followStatus: json["followStatus"],
        totalWalkDogTime: json["totalWalkDogTime"],
        targetRule: TargetRule.fromJson(json["targetRule"]),
        fansNotifyStatus: json["fansNotifyStatus"],
        deviceStatus: json["deviceStatus"],
        userMember: UserMember.fromJson(json["userMember"]),
        tribeFirstStatus: json["tribeFirstStatus"],
        validCouponCount: json["validCouponCount"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "userinfo": userinfo.toJson(),
        "userlevel": userlevel.toJson(),
        "usermedalList": List<dynamic>.from(usermedalList.map((x) => x)),
        "petCount": petCount,
        "messageCount": messageCount,
        "fansCount": fansCount,
        "followCount": followCount,
        "agreeCount": agreeCount,
        "isSelf": isSelf,
        "followStatus": followStatus,
        "totalWalkDogTime": totalWalkDogTime,
        "targetRule": targetRule.toJson(),
        "fansNotifyStatus": fansNotifyStatus,
        "deviceStatus": deviceStatus,
        "userMember": userMember.toJson(),
        "tribeFirstStatus": tribeFirstStatus,
        "validCouponCount": validCouponCount,
    };
}

class TargetRule {
    TargetRule({
        this.ruleId,
        this.level,
        this.growthValue,
        this.createTime,
        this.modifyTime,
        this.delTime,
        this.isFlag,
        this.delFlag,
        this.modifyPerson,
    });

    int ruleId;
    String level;
    int growthValue;
    DateTime createTime;
    DateTime modifyTime;
    DateTime delTime;
    String isFlag;
    String delFlag;
    int modifyPerson;

    factory TargetRule.fromJson(Map<String, dynamic> json) => TargetRule(
        ruleId: json["ruleId"],
        level: json["level"],
        growthValue: json["growthValue"],
        createTime: DateTime.parse(json["createTime"]),
        modifyTime: DateTime.parse(json["modifyTime"]),
        delTime: DateTime.parse(json["delTime"]),
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
        modifyPerson: json["modifyPerson"],
    );

    Map<String, dynamic> toJson() => {
        "ruleId": ruleId,
        "level": level,
        "growthValue": growthValue,
        "createTime": createTime.toIso8601String(),
        "modifyTime": modifyTime.toIso8601String(),
        "delTime": delTime.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
        "modifyPerson": modifyPerson,
    };
}

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
    );

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
    };
}

class UserMember {
    UserMember({
        this.rankId,
        this.rankName,
        this.plusStatus,
        this.plusType,
        this.rankValue,
        this.jifen,
        this.nextRankNeedValue,
    });

    int rankId;
    String rankName;
    String plusStatus;
    String plusType;
    int rankValue;
    int jifen;
    int nextRankNeedValue;

    factory UserMember.fromJson(Map<String, dynamic> json) => UserMember(
        rankId: json["rankId"],
        rankName: json["rankName"],
        plusStatus: json["plusStatus"],
        plusType: json["plusType"],
        rankValue: json["rankValue"],
        jifen: json["jifen"],
        nextRankNeedValue: json["nextRankNeedValue"],
    );

    Map<String, dynamic> toJson() => {
        "rankId": rankId,
        "rankName": rankName,
        "plusStatus": plusStatus,
        "plusType": plusType,
        "rankValue": rankValue,
        "jifen": jifen,
        "nextRankNeedValue": nextRankNeedValue,
    };
}

class Userinfo {
    Userinfo({
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
        this.sex,
        this.intro,
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
    double accountBalance;
    String province;
    String city;
    String sex;
    String intro;
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

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
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
        sex: json["sex"],
        intro: json["intro"],
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
        "sex": sex,
        "intro": intro,
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

class Userlevel {
    Userlevel({
        this.userlevelId,
        this.userId,
        this.level,
        this.growthValue,
        this.createTime,
        this.modifyTime,
        this.isFlag,
        this.delFlag,
    });

    int userlevelId;
    int userId;
    String level;
    int growthValue;
    DateTime createTime;
    DateTime modifyTime;
    String isFlag;
    String delFlag;

    factory Userlevel.fromJson(Map<String, dynamic> json) => Userlevel(
        userlevelId: json["userlevelId"],
        userId: json["userId"],
        level: json["level"],
        growthValue: json["growthValue"],
        createTime: DateTime.parse(json["createTime"]),
        modifyTime: DateTime.parse(json["modifyTime"]),
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
    );

    Map<String, dynamic> toJson() => {
        "userlevelId": userlevelId,
        "userId": userId,
        "level": level,
        "growthValue": growthValue,
        "createTime": createTime.toIso8601String(),
        "modifyTime": modifyTime.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}
