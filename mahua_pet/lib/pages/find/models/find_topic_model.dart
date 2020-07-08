// To parse this JSON data, do
//
//     final findTopicModel = findTopicModelFromJson(jsonString);

import 'dart:convert';

FindTopicModel findTopicModelFromJson(String str) => FindTopicModel.fromJson(json.decode(str));

String findTopicModelToJson(FindTopicModel data) => json.encode(data.toJson());

class FindTopicModel {
    FindTopicModel({
        this.labelId,
        this.labelName,
        this.labelType,
        this.labelDesc,
        this.labelImg,
        this.labelIcon,
        this.weight,
        this.isHot,
        this.isFlag,
        this.delFlag,
        this.createTime,
        this.modifyTime,
        this.createPerson,
        this.modifyPerson,
        this.userCount,
        this.readNUm,
    });

    int labelId;
    String labelName;
    String labelType;
    String labelDesc;
    String labelImg;
    String labelIcon;
    int weight;
    String isHot;
    String isFlag;
    String delFlag;
    String createTime;
    String modifyTime;
    int createPerson;
    int modifyPerson;
    int userCount;
    int readNUm;

    factory FindTopicModel.fromJson(Map<String, dynamic> json) => FindTopicModel(
        labelId: json["labelId"],
        labelName: json["labelName"],
        labelType: json["labelType"],
        labelDesc: json["labelDesc"],
        labelImg: json["labelImg"],
        labelIcon: json["labelIcon"],
        weight: json["weight"],
        isHot: json["isHot"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
        createTime: json["createTime"] ?? '',
        modifyTime: json["modifyTime"],
        createPerson: json["createPerson"],
        modifyPerson: json["modifyPerson"],
        userCount: json["userCount"],
        readNUm: json["readNUm"],
    );

    Map<String, dynamic> toJson() => {
        "labelId": labelId,
        "labelName": labelName,
        "labelType": labelType,
        "labelDesc": labelDesc,
        "labelImg": labelImg,
        "labelIcon": labelIcon,
        "weight": weight,
        "isHot": isHot,
        "isFlag": isFlag,
        "delFlag": delFlag,
        "createTime": createTime,
        "modifyTime": modifyTime,
        "createPerson": createPerson,
        "modifyPerson": modifyPerson,
        "userCount": userCount,
        "readNUm": readNUm,
    };
}
