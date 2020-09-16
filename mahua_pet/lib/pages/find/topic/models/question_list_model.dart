// To parse this JSON data, do
//
//     final questionListModel = questionListModelFromJson(jsonString);

import 'dart:convert';

QuestionListModel questionListModelFromJson(String str) => QuestionListModel.fromJson(json.decode(str));

String questionListModelToJson(QuestionListModel data) => json.encode(data.toJson());

class QuestionListModel {
    QuestionListModel({
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

    factory QuestionListModel.fromJson(Map<String, dynamic> json) => QuestionListModel(
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
