// To parse this JSON data, do
//
//     final swiperModel = swiperModelFromJson(jsonString);

import 'dart:convert';

SwiperModel swiperModelFromJson(String str) => SwiperModel.fromJson(json.decode(str));

String swiperModelToJson(SwiperModel data) => json.encode(data.toJson());

class SwiperModel {
    SwiperModel({
        this.advertUnitId,
        this.advertUnitName,
        this.advertUnitType,
        this.advertDirectId,
        this.directName,
        this.directImg,
        this.directType,
        this.directHref,
        this.relationSort,
        this.advertType,
        this.startTime,
        this.endTime,
        this.nowTime,
    });

    int advertUnitId;
    String advertUnitName;
    String advertUnitType;
    int advertDirectId;
    String directName;
    String directImg;
    String directType;
    String directHref;
    int relationSort;
    String advertType;
    DateTime startTime;
    DateTime endTime;
    DateTime nowTime;

    factory SwiperModel.fromJson(Map<String, dynamic> json) => SwiperModel(
        advertUnitId: json["advertUnitId"],
        advertUnitName: json["advertUnitName"],
        advertUnitType: json["advertUnitType"],
        advertDirectId: json["advertDirectId"],
        directName: json["directName"],
        directImg: json["directImg"],
        directType: json["directType"],
        directHref: json["directHref"],
        relationSort: json["relationSort"],
        advertType: json["advertType"],
    );

    Map<String, dynamic> toJson() => {
        "advertUnitId": advertUnitId,
        "advertUnitName": advertUnitName,
        "advertUnitType": advertUnitType,
        "advertDirectId": advertDirectId,
        "directName": directName,
        "directImg": directImg,
        "directType": directType,
        "directHref": directHref,
        "relationSort": relationSort,
        "advertType": advertType,
    };
}
