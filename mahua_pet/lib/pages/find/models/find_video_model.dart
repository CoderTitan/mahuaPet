// To parse this JSON data, do
//
//     final findVideoModel = findVideoModelFromJson(jsonString);

import 'dart:convert';

FindVideoModel findVideoModelFromJson(String str) => FindVideoModel.fromJson(json.decode(str));

String findVideoModelToJson(FindVideoModel data) => json.encode(data.toJson());

class FindVideoModel {
    FindVideoModel({
        this.messageId,
        this.messageInfo,
        this.userId,
        this.nickName,
        this.headImg,
        this.fileId,
        this.fileUrl,
        this.cntComment,
        this.cntRead,
        this.cntAgree,
        this.cntTranspond,
        this.collectionNum,
        this.videoCover,
        this.agreeStatus,
        this.collectionStatus,
        this.createTime,
        this.coverHeight,
        this.coverWidth,
        this.atusers,
        this.labelId,
        this.labelName,
        this.isSelf,
        this.followStatus,
        this.sex,
        this.intro,
    });

    int messageId;
    String messageInfo;
    int userId;
    String nickName;
    String headImg;
    int fileId;
    String fileUrl;
    int cntComment;
    int cntRead;
    int cntAgree;
    int cntTranspond;
    String collectionNum;
    String videoCover;
    String agreeStatus;
    String collectionStatus;
    String createTime;
    String coverHeight;
    String coverWidth;
    List<dynamic> atusers;
    int labelId;
    String labelName;
    String isSelf;
    String followStatus;
    String sex;
    String intro;

    factory FindVideoModel.fromJson(Map<String, dynamic> json) => FindVideoModel(
        messageId: json["messageId"],
        messageInfo: json["messageInfo"],
        userId: json["userId"],
        nickName: json["nickName"],
        headImg: json["headImg"],
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        cntComment: json["cntComment"],
        cntRead: json["cntRead"],
        cntAgree: json["cntAgree"],
        cntTranspond: json["cntTranspond"],
        collectionNum: json["collectionNum"],
        videoCover: json["videoCover"],
        agreeStatus: json["agreeStatus"],
        collectionStatus: json["collectionStatus"],
        createTime: json["createTime"],
        coverHeight: json["coverHeight"],
        coverWidth: json["coverWidth"],
        atusers: List<dynamic>.from(json["atusers"].map((x) => x)),
        labelId: json["labelId"],
        labelName: json["labelName"],
        isSelf: json["isSelf"],
        followStatus: json["followStatus"],
        sex: json["sex"],
        intro: json["intro"],
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "messageInfo": messageInfo,
        "userId": userId,
        "nickName": nickName,
        "headImg": headImg,
        "fileId": fileId,
        "fileUrl": fileUrl,
        "cntComment": cntComment,
        "cntRead": cntRead,
        "cntAgree": cntAgree,
        "cntTranspond": cntTranspond,
        "collectionNum": collectionNum,
        "videoCover": videoCover,
        "agreeStatus": agreeStatus,
        "collectionStatus": collectionStatus,
        "createTime": createTime,
        "coverHeight": coverHeight,
        "coverWidth": coverWidth,
        "atusers": List<dynamic>.from(atusers.map((x) => x)),
        "labelId": labelId,
        "labelName": labelName,
        "isSelf": isSelf,
        "followStatus": followStatus,
        "sex": sex,
        "intro": intro,
    };
}
