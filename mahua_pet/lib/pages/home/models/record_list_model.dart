// To parse this JSON data, do
//
//     final recordListModel = recordListModelFromJson(jsonString);

import 'dart:convert';

RecordListModel recordListModelFromJson(String str) => RecordListModel.fromJson(json.decode(str));

String recordListModelToJson(RecordListModel data) => json.encode(data.toJson());

class RecordListModel {
    RecordListModel({
        this.growTempleId,
        this.name,
        this.icon,
        this.type,
        this.growTempleValues,
        this.templePetValueId,
        this.value,
    });

    int growTempleId;
    String name;
    String icon;
    String type;
    List<RecordChildModel> growTempleValues;
    int templePetValueId;
    String value;

    factory RecordListModel.fromJson(Map<String, dynamic> json) => RecordListModel(
        growTempleId: json["growTempleId"],
        name: json["name"],
        icon: json["icon"],
        type: json["type"],
        growTempleValues: List<RecordChildModel>.from((json["growTempleValues"] ?? []).map((x) => RecordChildModel.fromJson(x))),
        templePetValueId: json["templePetValueId"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "growTempleId": growTempleId,
        "name": name,
        "icon": icon,
        "type": type,
        "growTempleValues": List<dynamic>.from(growTempleValues.map((x) => x.toJson())),
        "templePetValueId": templePetValueId,
        "value": value,
    };
}

class RecordChildModel {
    RecordChildModel({
        this.growTempleValueId,
        this.growTempleId,
        this.type,
        this.focusImg,
        this.unfocusImg,
        this.memo,
        this.value,
        this.isFlag,
        this.delFlag,
        this.createTime,
        this.modifyTime,
    });

    int growTempleValueId;
    int growTempleId;
    String type;
    String focusImg;
    String unfocusImg;
    String memo;
    String value;
    String isFlag;
    String delFlag;
    String createTime;
    String modifyTime;

    factory RecordChildModel.fromJson(Map<String, dynamic> json) => RecordChildModel(
        growTempleValueId: json["growTempleValueId"],
        growTempleId: json["growTempleId"],
        type: json["type"],
        focusImg: json["focusImg"],
        unfocusImg: json["unfocusImg"],
        memo: json["memo"],
        value: json["value"],
        isFlag: json["isFlag"],
        delFlag: json["delFlag"],
        createTime: json["createTime"],
        modifyTime: json["modifyTime"],
    );

    Map<String, dynamic> toJson() => {
        "growTempleValueId": growTempleValueId,
        "growTempleId": growTempleId,
        "type": type,
        "focusImg": focusImg,
        "unfocusImg": unfocusImg,
        "memo": memo,
        "value": value,
        "isFlag": isFlag,
        "delFlag": delFlag,
        "createTime": createTime,
        "modifyTime": modifyTime,
    };
}
