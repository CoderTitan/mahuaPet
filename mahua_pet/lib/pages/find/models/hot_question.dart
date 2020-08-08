// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
    QuestionModel({
        this.questionId,
        this.tribeId,
        this.title,
        this.userId,
        this.questionReadNum,
        this.answerNum,
        this.agreeNum,
        this.commentNum,
        this.nickname,
        this.headImg,
        this.tribeName,
        this.firstAnswer,
        this.firstFile,
        this.fileType,
        this.textType,
        this.answerUserId,
        this.answerId,
        this.agreeStatus,
    });

    int questionId;
    int tribeId;
    String title;
    int userId;
    int questionReadNum;
    int answerNum;
    int agreeNum;
    int commentNum;
    String nickname;
    String headImg;
    String tribeName;
    String firstAnswer;
    String firstFile;
    String fileType;
    String textType;
    int answerUserId;
    int answerId;
    String agreeStatus;

    factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionId: json["questionId"],
        tribeId: json["tribeId"],
        title: json["title"],
        userId: json["userId"],
        questionReadNum: json["questionReadNum"],
        answerNum: json["answerNum"],
        agreeNum: json["agreeNum"],
        commentNum: json["commentNum"],
        nickname: json["nickname"],
        headImg: json["headImg"],
        tribeName: json["tribeName"],
        firstAnswer: json["firstAnswer"],
        firstFile: json["firstFile"],
        fileType: json["fileType"],
        textType: json["textType"],
        answerUserId: json["answerUserId"],
        answerId: json["answerId"],
        agreeStatus: json["agreeStatus"],
    );

    Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "tribeId": tribeId,
        "title": title,
        "userId": userId,
        "questionReadNum": questionReadNum,
        "answerNum": answerNum,
        "agreeNum": agreeNum,
        "commentNum": commentNum,
        "nickname": nickname,
        "headImg": headImg,
        "tribeName": tribeName,
        "firstAnswer": firstAnswer,
        "firstFile": firstFile,
        "fileType": fileType,
        "textType": textType,
        "answerUserId": answerUserId,
        "answerId": answerId,
        "agreeStatus": agreeStatus,
    };
}

/**
{
  "questionId": 262,
  "tribeId": 64,
  "title": "你家的狗做过哪些不可思议的事?",
  "userId": 86767,
  "questionReadNum": 136,
  "answerNum": 5,
  "agreeNum": 0,
  "commentNum": 57,
  "nickname": "喜刷刷运营中心",
  "headImg": "https://static.ieasydog.com/dog/d329fc28f201454c86ccf3271b1d6cbc.png",
  "tribeName": "约克夏",
  "firstAnswer": "找东西，对钱味尤其敏感。妈特别稀罕它，它把爸爸藏的私房钱全翻了出来。养了两年多我爸才发现狗子会帮我妈找钱，趁妈妈跟我外出偷偷把狗带回老家送人了（告诉我们说是，遛狗时跑丢了。后爆发了家庭战争，冷战了很久。）同年，一家人回老家过年年后，爸送狗的那家叔叔带狗上门拜年（老家爷爷家），各种解释不能养把狗送了回来（爸脸色特逗）o(*≧▽≦)ツ┏━┓。又过了没几天，爷爷养的看门狗莫名全身抽搐莫名死亡，而妈妈准备带回家的狗子自然被爷爷扣下了成为替代狗。后来，爷爷打电话把我爸狠狠的臭骂了一顿，说他坑爹，狗把他藏的私房钱带存折全翻叼给我奶奶了，还怀疑我爸为了留下狗子不让我妈带回家翻钱，故意弄死他原来养的狗。（一大家子人都认为是爸把狗弄死的。连妈妈吵架都说，为了个人目的连狗都不放过。一生黑，不解释。）奶奶特宝贝狗子，一天三顿外加零食，还亲自带着外出遛弯，绝对禁止任何人喂养尤其是我爷爷。",
  "firstFile": "https://static.ieasydog.com/dog/1585195313743.jpg",
  "fileType": "0",
  "textType": "3",
  "answerUserId": 83001,
  "answerId": 1475,
  "agreeStatus": "1"
}
 */