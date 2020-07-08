// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    CommentModel({
        this.commentId,
        this.commentInfo,
        this.userId,
        this.nickname,
        this.headImg,
        this.replySize,
        this.publishTime,
        this.cntReply,
        this.userLoginId,
        this.commentReplyVOs,
        this.atusers,
        this.petDays,
        this.authorUserId,
        this.cntAgree,
        this.agreeStatus,
    });

    int commentId;
    String commentInfo;
    int userId;
    String nickname;
    String headImg;
    int replySize;
    String publishTime;
    int cntReply;
    int userLoginId;
    List<CommentReplyVo> commentReplyVOs;
    List<dynamic> atusers;
    String petDays;
    int authorUserId;
    int cntAgree;
    String agreeStatus;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json["commentId"],
        commentInfo: json["commentInfo"],
        userId: json["userId"],
        nickname: json["nickname"],
        headImg: json["headImg"],
        replySize: json["replySize"],
        publishTime: json["publishTime"],
        cntReply: json["cntReply"],
        userLoginId: json["userLoginId"],
        commentReplyVOs: List<CommentReplyVo>.from((json["commentReplyVOs"] ?? []).map((x) => CommentReplyVo.fromJson(x))) ?? [],
        atusers: List<dynamic>.from(json["atusers"].map((x) => x)),
        petDays: json["petDays"],
        authorUserId: json["authorUserId"],
        cntAgree: json["cntAgree"],
        agreeStatus: json["agreeStatus"],
    );

    Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentInfo": commentInfo,
        "userId": userId,
        "nickname": nickname,
        "headImg": headImg,
        "replySize": replySize,
        "publishTime": publishTime,
        "cntReply": cntReply,
        "userLoginId": userLoginId,
        "commentReplyVOs": List<dynamic>.from(commentReplyVOs.map((x) => x.toJson())),
        "atusers": List<dynamic>.from(atusers.map((x) => x)),
        "petDays": petDays,
        "authorUserId": authorUserId,
        "cntAgree": cntAgree,
        "agreeStatus": agreeStatus,
    };
}

class CommentReplyVo {
    CommentReplyVo({
        this.userId,
        this.replyUserId,
        this.replyNickname,
        this.commentInfo,
        this.replyId,
        this.headImg,
        this.nickname,
        this.atusers,
        this.replyPublishTime,
        this.petDays,
    });

    int userId;
    int replyUserId;
    String replyNickname;
    String commentInfo;
    int replyId;
    String headImg;
    String nickname;
    List<dynamic> atusers;
    String replyPublishTime;
    String petDays;

    factory CommentReplyVo.fromJson(Map<String, dynamic> json) => CommentReplyVo(
        userId: json["userId"],
        replyUserId: json["replyUserId"],
        replyNickname: json["replyNickname"],
        commentInfo: json["commentInfo"],
        replyId: json["replyId"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        atusers: List<dynamic>.from(json["atusers"].map((x) => x)),
        replyPublishTime: json["replyPublishTime"],
        petDays: json["petDays"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "replyUserId": replyUserId,
        "replyNickname": replyNickname,
        "commentInfo": commentInfo,
        "replyId": replyId,
        "headImg": headImg,
        "nickname": nickname,
        "atusers": List<dynamic>.from(atusers.map((x) => x)),
        "replyPublishTime": replyPublishTime,
        "petDays": petDays,
    };
}
