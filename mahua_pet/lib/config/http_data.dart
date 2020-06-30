

class HttpData {
    HttpData({
        this.status,
        this.message,
        this.data,
        this.isSuccess,
    });

    int status;
    String message;
    dynamic data;
    bool isSuccess;

    factory HttpData.fromJson(Map<String, dynamic> json) => HttpData(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: json["data"],
        isSuccess: json["rel"] ?? false,
    );
}

