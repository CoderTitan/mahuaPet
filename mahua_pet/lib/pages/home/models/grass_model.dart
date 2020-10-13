// To parse this JSON data, do
//
//     final grassModel = grassModelFromJson(jsonString);

import 'dart:convert';

GrassModel grassModelFromJson(String str) => GrassModel.fromJson(json.decode(str));

String grassModelToJson(GrassModel data) => json.encode(data.toJson());

class GrassModel {
    GrassModel({
        this.trialReportId,
        this.reportType,
        this.reportTitle,
        this.messageInfo,
        this.isHot,
        this.messageCollectnum,
        this.messageCommentnum,
        this.messageTranspondnum,
        this.messageAgreenum,
        this.messageReadnum,
        this.agreeStatus,
        this.auditStatus,
        this.userId,
        this.headImg,
        this.nickname,
        this.labelId,
        this.labelName,
        this.fileUrl,
    });

    int trialReportId;
    String reportType;
    String reportTitle;
    String messageInfo;
    String isHot;
    String messageCollectnum;
    String messageCommentnum;
    String messageTranspondnum;
    String messageAgreenum;
    String messageReadnum;
    String agreeStatus;
    String auditStatus;
    int userId;
    String headImg;
    String nickname;
    int labelId;
    String labelName;
    String fileUrl;

    factory GrassModel.fromJson(Map<String, dynamic> json) => GrassModel(
        trialReportId: json["trialReportId"],
        reportType: json["reportType"],
        reportTitle: json["reportTitle"],
        messageInfo: json["messageInfo"],
        isHot: json["isHot"],
        messageCollectnum: json["messageCollectnum"],
        messageCommentnum: json["messageCommentnum"],
        messageTranspondnum: json["messageTranspondnum"],
        messageAgreenum: json["messageAgreenum"],
        messageReadnum: json["messageReadnum"],
        agreeStatus: json["agreeStatus"],
        auditStatus: json["auditStatus"],
        userId: json["userId"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        labelId: json["labelId"],
        labelName: json["labelName"],
        fileUrl: json["fileUrl"],
    );

    Map<String, dynamic> toJson() => {
        "trialReportId": trialReportId,
        "reportType": reportType,
        "reportTitle": reportTitle,
        "messageInfo": messageInfo,
        "isHot": isHot,
        "messageCollectnum": messageCollectnum,
        "messageCommentnum": messageCommentnum,
        "messageTranspondnum": messageTranspondnum,
        "messageAgreenum": messageAgreenum,
        "messageReadnum": messageReadnum,
        "agreeStatus": agreeStatus,
        "auditStatus": auditStatus,
        "userId": userId,
        "headImg": headImg,
        "nickname": nickname,
        "labelId": labelId,
        "labelName": labelName,
        "fileUrl": fileUrl,
    };
}
