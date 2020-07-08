// To parse this JSON data, do
//
//     final focusModel = focusModelFromJson(jsonString);

import 'dart:convert';

FocusModel focusModelFromJson(String str) => FocusModel.fromJson(json.decode(str));

String focusModelToJson(FocusModel data) => json.encode(data.toJson());

class FocusModel {
    FocusModel({
        this.userId,
        this.headImg,
        this.nickname,
        this.petBreed,
        this.relationNum,
    });

    int userId;
    String headImg;
    String nickname;
    String petBreed;
    int relationNum;
    bool isRelation = false;

    factory FocusModel.fromJson(Map<String, dynamic> json) => FocusModel(
        userId: json["userId"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        petBreed: json["petBreed"],
        relationNum: json["relationNum"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "headImg": headImg,
        "nickname": nickname,
        "petBreed": petBreed,
        "relationNum": relationNum,
    };
}
