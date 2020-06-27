import 'dart:convert';

HttpData httpDataFromJson(String str) => HttpData.fromJson(json.decode(str));

String httpDataToJson(HttpData data) => json.encode(data.toJson());

class HttpData {
    HttpData({
        this.status,
        this.message,
        this.data,
        this.isSuccess,
    });

    int status;
    String message;
    Map<String, dynamic> data;
    bool isSuccess;

    factory HttpData.fromJson(Map<String, dynamic> json) => HttpData(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        isSuccess: json["rel"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "rel": isSuccess,
    };
}

