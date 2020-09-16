// To parse this JSON data, do
//
//     final breedModel = breedModelFromJson(jsonString);

import 'dart:convert';

BreedModel breedModelFromJson(String str) => BreedModel.fromJson(json.decode(str));

String breedModelToJson(BreedModel data) => json.encode(data.toJson());

class BreedModel {
    BreedModel({
        this.tribeId,
        this.tribeName,
        this.headImg,
        this.tribeDescription,
        this.tribeMessageCount,
        this.tribeUserCount,
        this.joinStatus,
        this.userCount,
        this.dogBreed,
        this.followStatus,
    });

    String tribeId;
    String tribeName;
    String headImg;
    String tribeDescription;
    String tribeMessageCount;
    String tribeUserCount;
    String joinStatus;
    String dogBreed;
    String followStatus;
    int userCount;

    factory BreedModel.fromJson(Map<String, dynamic> json) => BreedModel(
        tribeId: json["tribeId"] ?? '',
        tribeName: json["tribeName"] ?? '',
        headImg: json["headImg"] ?? '',
        tribeDescription: json["tribeDescription"] ?? '',
        tribeMessageCount: json["tribeMessageCount"],
        tribeUserCount: json["tribeUserCount"] ?? '0',
        joinStatus: json["joinStatus"],
        dogBreed: json["dogBreed"] ?? '',
        followStatus: json["followStatus"] ?? '',
        userCount: json["userCount"],
    );

    Map<String, dynamic> toJson() => {
        "tribeId": tribeId,
        "tribeName": tribeName,
        "headImg": headImg ?? '',
        "tribeDescription": tribeDescription,
        "tribeMessageCount": tribeMessageCount,
        "tribeUserCount": tribeUserCount,
        "joinStatus": joinStatus,
        "userCount": userCount,
    };
}
