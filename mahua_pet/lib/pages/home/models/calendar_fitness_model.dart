// To parse this JSON data, do
//
//     final calendarFitModel = calendarFitModelFromJson(jsonString);

import 'dart:convert';

CalendarFitModel calendarFitModelFromJson(String str) => CalendarFitModel.fromJson(json.decode(str));

String calendarFitModelToJson(CalendarFitModel data) => json.encode(data.toJson());

class CalendarFitModel {
    CalendarFitModel({
        this.diseaseRecordsId,
        this.symptom,
        this.growManagerId,
        this.diagnosticResult,
        this.desc,
        this.isFlag,
        this.delFlag,
        this.createTime,
        this.diseaseFiles,
        this.year,
        this.month,
        this.day,
    });

    int diseaseRecordsId;
    String symptom;
    int growManagerId;
    String diagnosticResult;
    String desc;
    String isFlag;
    String delFlag;
    String createTime;
    List<DiseaseFile> diseaseFiles;
    String year;
    String month;
    String day;

    factory CalendarFitModel.fromJson(Map<String, dynamic> json) => CalendarFitModel(
        diseaseRecordsId: json["diseaseRecordsId"],
        symptom: json["symptom"],
        growManagerId: json["growManagerId"],
        diagnosticResult: json["diagnosticResult"],
        desc: json["desc"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
        createTime: json["createTime"],
        diseaseFiles: List<DiseaseFile>.from(json["diseaseFiles"].map((x) => DiseaseFile.fromJson(x))),
        year: json["year"],
        month: json["month"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "diseaseRecordsId": diseaseRecordsId,
        "symptom": symptom,
        "growManagerId": growManagerId,
        "diagnosticResult": diagnosticResult,
        "desc": desc,
        "isFlag": isFlag,
        "delFlag": delFlag,
        "createTime": createTime,
        "diseaseFiles": List<dynamic>.from(diseaseFiles.map((x) => x.toJson())),
        "year": year,
        "month": month,
        "day": day,
    };
}

class DiseaseFile {
    DiseaseFile({
        this.fileId,
        this.userId,
        this.diseaseRecordsId,
        this.fileUrl,
        this.fileType,
        this.height,
        this.width,
        this.isFlag,
        this.delFlag,
    });

    int fileId;
    int userId;
    int diseaseRecordsId;
    String fileUrl;
    String fileType;
    String height;
    String width;
    String isFlag;
    String delFlag;

    factory DiseaseFile.fromJson(Map<String, dynamic> json) => DiseaseFile(
        fileId: json["fileId"],
        userId: json["userId"],
        diseaseRecordsId: json["diseaseRecordsId"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        height: json["height"],
        width: json["width"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "userId": userId,
        "diseaseRecordsId": diseaseRecordsId,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "height": height,
        "width": width,
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}
