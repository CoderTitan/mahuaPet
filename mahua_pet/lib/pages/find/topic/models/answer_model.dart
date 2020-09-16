// To parse this JSON data, do
//
//     final answerModel = answerModelFromJson(jsonString);

import 'dart:convert';

AnswerModel answerModelFromJson(String str) => AnswerModel.fromJson(json.decode(str));

String answerModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
    AnswerModel({
        this.answerId,
        this.answerUserId,
        this.textType,
        this.htmlDescription,
        this.textDescription,
        this.commentNum,
        this.agreeNum,
        this.readNum,
        this.firstFile,
        this.fileType,
        this.createTime,
        this.nickname,
        this.headImg,
        this.followStatus,
        this.isAgree,
    });

    int answerId;
    int answerUserId;
    String textType;
    String htmlDescription;
    String textDescription;
    int commentNum;
    int agreeNum;
    int readNum;
    String firstFile;
    String fileType;
    String createTime;
    String nickname;
    String headImg;
    String followStatus;
    String isAgree;

    factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        answerId: json["answerId"],
        answerUserId: json["answerUserId"],
        textType: json["textType"],
        htmlDescription: json["htmlDescription"],
        textDescription: json["textDescription"],
        commentNum: json["commentNum"],
        agreeNum: json["agreeNum"],
        readNum: json["readNum"],
        firstFile: json["firstFile"],
        fileType: json["fileType"],
        createTime: json["createTime"],
        nickname: json["nickname"],
        headImg: json["headImg"],
        followStatus: json["followStatus"],
        isAgree: json["isAgree"],
    );

    Map<String, dynamic> toJson() => {
        "answerId": answerId,
        "answerUserId": answerUserId,
        "textType": textType,
        "htmlDescription": htmlDescription,
        "textDescription": textDescription,
        "commentNum": commentNum,
        "agreeNum": agreeNum,
        "readNum": readNum,
        "firstFile": firstFile,
        "fileType": fileType,
        "createTime": createTime,
        "nickname": nickname,
        "headImg": headImg,
        "followStatus": followStatus,
        "isAgree": isAgree,
    };
}
