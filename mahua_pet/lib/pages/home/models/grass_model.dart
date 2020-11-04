// To parse this JSON data, do
//
//     final grassModel = grassModelFromJson(jsonString);

import 'dart:convert';

GrassModel grassModelFromJson(String str) => GrassModel.fromJson(json.decode(str));

String grassModelToJson(GrassModel data) => json.encode(data.toJson());

class GrassModel {
    GrassModel({
        this.trialReportId,
        this.userId,
        this.reportTitle,
        this.reportType,
        this.auditStatus,
        this.messageInfo,
        this.messageAgreenum,
        this.messageCommentnum,
        this.labelName,
        this.nickname,
        this.headImg,
        this.followStatus,
        this.collectionCount,
        this.collectionStatus,
        this.agreeStatus,
        this.fileList,
        this.fileUrl,
        this.isSelf,
        this.createTime
    });

    int trialReportId;
    int userId;
    String reportTitle;
    String reportType;
    String auditStatus;
    String messageInfo;
    String messageAgreenum;
    String messageCommentnum;
    String labelName;
    String nickname;
    String headImg;
    String followStatus;
    String collectionCount;
    String collectionStatus;
    String agreeStatus;
    String createTime;
    List<FileList> fileList;
    String fileUrl;
    bool isSelf;

    factory GrassModel.fromJson(Map<String, dynamic> json) => GrassModel(
        trialReportId: json["trialReportId"],
        userId: json["userId"],
        reportTitle: json["reportTitle"],
        reportType: json["reportType"],
        auditStatus: json["auditStatus"],
        messageInfo: json["messageInfo"],
        messageAgreenum: json["messageAgreenum"],
        messageCommentnum: json["messageCommentnum"],
        labelName: json["labelName"],
        nickname: json["nickname"],
        headImg: json["headImg"],
        followStatus: json["followStatus"],
        collectionCount: json["collectionCount"],
        collectionStatus: json["collectionStatus"],
        agreeStatus: json["agreeStatus"],
        fileUrl: json["fileUrl"],
        createTime: json["createTime"],
        fileList: List<FileList>.from((json["fileList"] ?? []).map((x) => FileList.fromJson(x))),
        isSelf: json["isSelf"],
    );

    Map<String, dynamic> toJson() => {
        "trialReportId": trialReportId,
        "userId": userId,
        "reportTitle": reportTitle,
        "reportType": reportType,
        "auditStatus": auditStatus,
        "messageInfo": messageInfo,
        "messageAgreenum": messageAgreenum,
        "messageCommentnum": messageCommentnum,
        "labelName": labelName,
        "nickname": nickname,
        "headImg": headImg,
        "followStatus": followStatus,
        "collectionCount": collectionCount,
        "collectionStatus": collectionStatus,
        "agreeStatus": agreeStatus,
        "fileUrl": fileUrl,
        "createTime": createTime,
        "fileList": List<dynamic>.from(fileList?.map((x) => x.toJson())),
        "isSelf": isSelf,
    };
}

class FileList {
    FileList({
        this.fileId,
        this.trialReportId,
        this.fileUrl,
        this.fileType,
        this.height,
        this.width,
    });

    int fileId;
    int trialReportId;
    String fileUrl;
    String fileType;
    String height;
    String width;

    factory FileList.fromJson(Map<String, dynamic> json) => FileList(
        fileId: json["fileId"],
        trialReportId: json["trialReportId"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        height: json["height"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "trialReportId": trialReportId,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "height": height,
        "width": width,
    };
}
