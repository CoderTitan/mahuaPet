// To parse this JSON data, do
//
//     final userLevel = userLevelFromJson(jsonString);

import 'dart:convert';

UserLevel userLevelFromJson(String str) => UserLevel.fromJson(json.decode(str));

String userLevelToJson(UserLevel data) => json.encode(data.toJson());

class UserLevel {
    UserLevel({
        this.userlevelId,
        this.userId,
        this.level,
        this.growthValue,
        this.createTime,
        this.isFlag,
        this.delFlag,
    });

    int userlevelId;
    int userId;
    String level;
    int growthValue;
    DateTime createTime;
    String isFlag;
    String delFlag;

    factory UserLevel.fromJson(Map<String, dynamic> json) => UserLevel(
        userlevelId: json["userlevelId"],
        userId: json["userId"],
        level: json["level"],
        growthValue: json["growthValue"],
        createTime: DateTime.parse(json["createTime"]),
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
    );

    Map<String, dynamic> toJson() => {
        "userlevelId": userlevelId,
        "userId": userId,
        "level": level,
        "growthValue": growthValue,
        "createTime": createTime?.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}
