
import 'dart:convert';


ConfigInfo configInfoFromJson(String str) => ConfigInfo.fromJson(json.decode(str));

String configInfoToJson(ConfigInfo data) => json.encode(data.toJson());

class ConfigInfo {
    ConfigInfo({
        this.eventBaseId,
        this.userId,
        this.eventCode,
        this.eventName,
        this.eventGroup,
        this.ip,
        this.province,
        this.city,
        this.area,
        this.clientVersion,
        this.sysVersion,
        this.platformType,
        this.registerType,
        this.loginType,
        this.registerChannel,
        this.deviceBrand,
        this.deviceModel,
        this.deviceNo,
        this.isFlag,
        this.delFlag,
    });

    int eventBaseId;
    int userId;
    String eventCode;
    String eventName;
    String eventGroup;
    String ip;
    String province;
    String city;
    String area;
    String clientVersion;
    String sysVersion;
    String platformType;
    String registerType;
    String loginType;
    String registerChannel;
    String deviceBrand;
    String deviceModel;
    String deviceNo;
    String isFlag;
    String delFlag;

    factory ConfigInfo.fromJson(Map<String, dynamic> json) {

      return ConfigInfo(
        eventBaseId: json["eventBaseId"],
        userId: json["userId"],
        eventCode: json["eventCode"],
        eventName: json["eventName"],
        eventGroup: json["eventGroup"],
        ip: json["ip"],
        province: json["province"],
        city: json["city"],
        area: json["area"],
        clientVersion: json["clientVersion"],
        sysVersion: json["sysVersion"],
        platformType: json["platformType"],
        registerType: json["registerType"],
        loginType: json["loginType"],
        registerChannel: json["registerChannel"],
        deviceBrand: json["deviceBrand"],
        deviceModel: json["deviceModel"],
        deviceNo: json["deviceNo"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
      );
    }

    Map<String, dynamic> toJson() => {
        "eventBaseId": eventBaseId,
        "userId": userId,
        "eventCode": eventCode,
        "eventName": eventName,
        "eventGroup": eventGroup,
        "ip": ip,
        "province": province,
        "city": city,
        "area": area,
        "clientVersion": clientVersion,
        "sysVersion": sysVersion,
        "platformType": platformType,
        "registerType": registerType,
        "loginType": loginType,
        "registerChannel": registerChannel,
        "deviceBrand": deviceBrand,
        "deviceModel": deviceModel,
        "deviceNo": deviceNo,
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}

