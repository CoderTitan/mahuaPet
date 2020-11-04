// To parse this JSON data, do
//
//     final calendarRecordModel = calendarRecordModelFromJson(jsonString);

import 'dart:convert';

CalendarRecordModel calendarRecordModelFromJson(String str) => CalendarRecordModel.fromJson(json.decode(str));

String calendarRecordModelToJson(CalendarRecordModel data) => json.encode(data.toJson());

class CalendarRecordModel {
    CalendarRecordModel({
        this.growManagerId,
        this.year,
        this.month,
        this.day,
        this.petId,
        this.isRecord,
        this.isDiseaseRecord,
    });

    int growManagerId;
    String year;
    String month;
    String day;
    int petId;
    String isRecord;
    String isDiseaseRecord;

    factory CalendarRecordModel.fromJson(Map<String, dynamic> json) => CalendarRecordModel(
        growManagerId: json["growManagerId"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        petId: json["petId"],
        isRecord: json["isRecord"],
        isDiseaseRecord: json["isDiseaseRecord"],
    );

    Map<String, dynamic> toJson() => {
        "growManagerId": growManagerId,
        "year": year,
        "month": month,
        "day": day,
        "petId": petId,
        "isRecord": isRecord,
        "isDiseaseRecord": isDiseaseRecord,
    };
}
