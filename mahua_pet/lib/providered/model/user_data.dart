
// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';
import 'user_info.dart';
import 'user_level.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
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
    UserInfo userinfo;
    UserLevel userlevel;
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

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: User.fromJson(json["user"] ?? {}),
        userinfo: UserInfo.fromJson(json["userinfo"]),
        userlevel: UserLevel.fromJson(json["userlevel"]),
        usermedalList: List<dynamic>.from(json["usermedalList"].map((x) => x)) ?? [],
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
        "user": user?.toJson(),
        "userinfo": userinfo?.toJson(),
        "userlevel": userlevel?.toJson(),
        "usermedalList": List<dynamic>.from(usermedalList?.map((x) => x)),
        "petCount": petCount,
        "messageCount": messageCount,
        "fansCount": fansCount,
        "followCount": followCount,
        "agreeCount": agreeCount,
        "isSelf": isSelf,
        "followStatus": followStatus,
        "totalWalkDogTime": totalWalkDogTime,
        "targetRule": targetRule?.toJson(),
        "fansNotifyStatus": fansNotifyStatus,
        "deviceStatus": deviceStatus,
        "userMember": userMember?.toJson(),
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
        this.delTime,
        this.isFlag,
        this.delFlag,
    });

    int ruleId;
    String level;
    int growthValue;
    String createTime;
    String delTime;
    String isFlag;
    String delFlag;

    factory TargetRule.fromJson(Map<String, dynamic> json) => TargetRule(
        ruleId: json["ruleId"],
        level: json["level"],
        growthValue: json["growthValue"],
        createTime: json["createTime"],
        delTime: json["delTime"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
    );

    Map<String, dynamic> toJson() => {
        "ruleId": ruleId,
        "level": level,
        "growthValue": growthValue,
        "createTime": createTime,
        "delTime": delTime,
        "isFlag": isFlag,
        "delFlag": delFlag,
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
    String createTime;
    String modifyTime;
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
        createTime: json["createTime"],
        modifyTime: json["modifyTime"],
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
        "createTime": createTime,
        "modifyTime": modifyTime,
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
