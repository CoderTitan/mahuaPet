
import 'dart:convert';
import 'package:mahua_pet/providered/shared/shared_index.dart';

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
        this.registerTime,
        this.deviceBrand,
        this.deviceModel,
        this.deviceNo,
        this.createTime,
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
    DateTime registerTime;
    String deviceBrand;
    String deviceModel;
    String deviceNo;
    DateTime createTime;
    String isFlag;
    String delFlag;

    factory ConfigInfo.fromJson(Map<String, dynamic> json) {

      SharedUtils.setInt(ShareConstant.userId, json['userId'] ?? 0);
      SharedUtils.setString(ShareConstant.ip, json['ip'] ?? '');
      SharedUtils.setString(ShareConstant.province, json['province'] ?? '');
      SharedUtils.setString(ShareConstant.city, json['city'] ?? '');
      SharedUtils.setString(ShareConstant.area, json['area'] ?? '');
      SharedUtils.setString(ShareConstant.clientVersion, json['clientVersion'] ?? '');
      SharedUtils.setString(ShareConstant.sysVersion, json['sysVersion'] ?? '');
      SharedUtils.setString(ShareConstant.deviceBrand, json['deviceBrand'] ?? '');
      SharedUtils.setString(ShareConstant.deviceModel, json['deviceModel'] ?? '');
      SharedUtils.setString(ShareConstant.deviceNo, json['deviceNo'] ?? '');
      SharedUtils.setString(ShareConstant.loginType, json['loginType'] ?? '');

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
        registerTime: DateTime.parse(json["registerTime"]),
        deviceBrand: json["deviceBrand"],
        deviceModel: json["deviceModel"],
        deviceNo: json["deviceNo"],
        createTime: DateTime.parse(json["createTime"]),
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
        "registerTime": registerTime.toIso8601String(),
        "deviceBrand": deviceBrand,
        "deviceModel": deviceModel,
        "deviceNo": deviceNo,
        "createTime": createTime.toIso8601String(),
        "isFlag": isFlag,
        "delFlag": delFlag,
    };
}

