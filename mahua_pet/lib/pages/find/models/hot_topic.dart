// To parse this JSON data, do
//
//     final hotTopicModel = hotTopicModelFromJson(jsonString);

import 'dart:convert';

HotTopicModel hotTopicModelFromJson(String str) => HotTopicModel.fromJson(json.decode(str));

String hotTopicModelToJson(HotTopicModel data) => json.encode(data.toJson());

class HotTopicModel {
    HotTopicModel({
        this.tribeId,
        this.tribeName,
        this.headImg,
        this.recommendType,
        this.tribeUserCount,
        this.isCollect,
    });

    String tribeId;
    String tribeName;
    String headImg;
    String recommendType;
    String tribeUserCount;
    String isCollect;

    factory HotTopicModel.fromJson(Map<String, dynamic> json) => HotTopicModel(
        tribeId: json["tribeId"],
        tribeName: json["tribeName"],
        headImg: json["headImg"],
        recommendType: json["recommendType"],
        tribeUserCount: json["tribeUserCount"],
        isCollect: json["isCollect"],
    );

    Map<String, dynamic> toJson() => {
        "tribeId": tribeId,
        "tribeName": tribeName,
        "headImg": headImg,
        "recommendType": recommendType,
        "tribeUserCount": tribeUserCount,
        "isCollect": isCollect,
    };
}

/**
{
  "tribeId": "84",
  "tribeName": "比牧",
  "headImg": "https://static.ieasydog.com/dog/1584671458618.jpg",
  "recommendType": "0",
  "tribeUserCount": "3",
  "isCollect": "0"
}
 */