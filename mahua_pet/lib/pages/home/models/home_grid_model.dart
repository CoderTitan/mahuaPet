// To parse this JSON data, do
//
//     final recommendModel = recommendModelFromJson(jsonString);

import 'dart:convert';

HomeGridModel recommendModelFromJson(String str) => HomeGridModel.fromJson(json.decode(str));

String recommendModelToJson(HomeGridModel data) => json.encode(data.toJson());

class HomeGridModel {
    HomeGridModel({
        this.messageId,
        this.userId,
        this.messageType,
        this.videoCover,
        this.messageInfo,
        this.isHot,
        this.headImg,
        this.nickname,
        this.messageReadNum,
        this.messageAgreeNum,
        this.type,
        this.coverHeight,
        this.coverWidth,
        this.isSelf,
        this.atUsers,
        this.agreeStatus,
        this.messageLabelId,
        this.labelName,
    });

    int messageId;
    int userId;
    String messageType;
    String videoCover;
    String messageInfo;
    String isHot;
    String headImg;
    String nickname;
    String messageReadNum;
    String messageAgreeNum;
    int type;
    String coverHeight;
    String coverWidth;
    bool isSelf;
    List<dynamic> atUsers = [];
    String agreeStatus;
    int messageLabelId;
    String labelName;

    factory HomeGridModel.fromJson(Map<String, dynamic> json) => HomeGridModel(
        messageId: json["messageId"],
        userId: json["userId"],
        messageType: json["messageType"],
        videoCover: json["videoCover"],
        messageInfo: json["messageInfo"],
        isHot: json["isHot"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        messageReadNum: json["messageReadNum"],
        messageAgreeNum: json["messageAgreeNum"],
        type: json["type"],
        coverHeight: json["coverHeight"] ?? '1',
        coverWidth: json["coverWidth"] ?? '1',
        isSelf: json["isSelf"],
        atUsers: List<dynamic>.from((json["atUsers"] ?? []).map((x) => x)),
        agreeStatus: json["agreeStatus"] ?? '',
        messageLabelId: json["messageLabelId"] ?? 0,
        labelName: json["labelName"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "userId": userId,
        "messageType": messageType,
        "videoCover": videoCover,
        "messageInfo": messageInfo,
        "isHot": isHot,
        "headImg": headImg,
        "nickname": nickname,
        "messageReadNum": messageReadNum,
        "messageAgreeNum": messageAgreeNum,
        "type": type,
        "coverHeight": coverHeight,
        "coverWidth": coverWidth,
        "isSelf": isSelf,
        "atUsers": List<dynamic>.from(atUsers.map((x) => x)),
        "agreeStatus": agreeStatus,
        "messageLabelId": messageLabelId,
        "labelName": labelName,
    };
}
