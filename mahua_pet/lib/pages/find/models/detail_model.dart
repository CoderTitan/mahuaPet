// To parse this JSON data, do
//
//     final detailModel = detailModelFromJson(jsonString);

import 'dart:convert';
import 'package:mahua_pet/pages/find/models/focus_post_model.dart';

import 'comment_model.dart';

DetailModel detailModelFromJson(String str) => DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
    DetailModel({
        this.messageId,
        this.userId,
        this.nickName,
        this.headImg,
        this.city,
        this.level,
        this.messageInfo,
        this.files,
        this.createTime,
        this.messageType,
        this.isSelf,
        this.labelId,
        this.labelName,
        this.labelType,
        this.atusers,
        this.followStatus,
        this.cntAgree,
        this.agrees,
        this.agreeStatus,
        this.collectionsStatus,
        this.delFlag,
        this.commentNum,
        this.collectionNum,
    });

    int messageId;
    int userId;
    String nickName;
    String headImg;
    String city;
    String level;
    String messageInfo;
    List<FileElement> files;
    String createTime;
    String messageType;
    String isSelf;
    int labelId;
    String labelName;
    String labelType;
    List<dynamic> atusers;
    String followStatus;
    int cntAgree;
    List<Agree> agrees;
    String collectionsStatus;
    String agreeStatus;
    String delFlag;
    String commentNum;
    String collectionNum;
    List<CommentModel> commentList;

    factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        messageId: json["messageId"],
        userId: json["userId"],
        nickName: json["nickName"] ?? '',
        headImg: json["headImg"] ?? '',
        city: json["city"] ?? '',
        level: json["level"],
        messageInfo: json["messageInfo"] ?? '',
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        createTime: json["createTime"] ?? '',
        messageType: json["messageType"] ?? '',
        isSelf: json["isSelf"],
        labelId: json["labelId"] ?? 0,
        labelName: json["labelName"] ?? '',
        labelType: json["labelType"] ?? '',
        atusers: List<dynamic>.from(json["atusers"].map((x) => x)),
        followStatus: json["followStatus"] ?? '+关注',
        cntAgree: json["cntAgree"] ?? 0,
        agrees: List<Agree>.from(json["agrees"].map((x) => Agree.fromJson(x))),
        collectionsStatus: json["collectionsStatus"] ?? '0',
        agreeStatus: json["agreeStatus"] ?? '0',
        delFlag: json["delFlag"],
        commentNum: json["commentNum"],
        collectionNum: json["collectionNum"],
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "userId": userId,
        "nickName": nickName,
        "headImg": headImg,
        "city": city,
        "level": level,
        "messageInfo": messageInfo,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "createTime": createTime,
        "messageType": messageType,
        "isSelf": isSelf,
        "labelId": labelId,
        "labelName": labelName,
        "labelType": labelType,
        "atusers": List<dynamic>.from(atusers.map((x) => x)),
        "followStatus": followStatus,
        "cntAgree": cntAgree,
        "agrees": List<dynamic>.from(agrees.map((x) => x.toJson())),
        "collectionsStatus": collectionsStatus,
        "delFlag": delFlag,
        "commentNum": commentNum,
        "collectionNum": collectionNum,
    };
}

class Agree {
    Agree({
        this.userId,
        this.headImg,
        this.nickname,
        this.city,
        this.level,
    });

    int userId;
    String headImg;
    String nickname;
    String city;
    String level;

    factory Agree.fromJson(Map<String, dynamic> json) => Agree(
        userId: json["userId"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        city: json["city"] ?? '',
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "headImg": headImg,
        "nickname": nickname,
        "city": city ?? '',
        "level": level,
    };
}

class FileElement {
    FileElement({
        this.fileId,
        this.fileUrl,
        this.fileType,
        this.height,
        this.width,
        this.createTime,
    });

    int fileId;
    String fileUrl;
    String fileType;
    String height;
    String width;
    String createTime;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        height: json["height"],
        width: json["width"],
        createTime: json["createTime"],
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "height": height,
        "width": width,
        "createTime": createTime,
    };
}
