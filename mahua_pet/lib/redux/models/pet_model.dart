// To parse this JSON data, do
//
//     final petModel = petModelFromJson(jsonString);

import 'dart:convert';

enum PetSex {
  gg,
  mm,
}

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
    PetModel({
        this.petId,
        this.petImg,
        this.petName,
        this.petBreed,
        this.isSterilization,
        this.sex,
        this.birthday,
        this.adoptionDate,
        this.petKg,
        this.age,
        this.isLoss,
        this.isPair,
        this.day,
        this.breedId,
        this.backgroundUrl,
    });

    int petId;
    String petImg;
    String petName;
    String petBreed;
    String isSterilization;
    String sex;
    String birthday;
    String adoptionDate;
    String petKg;
    String age;
    String isLoss;
    String isPair;
    String day;
    int breedId;
    String backgroundUrl;

    factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        petId: json["petId"],
        petImg: json["petImg"],
        petName: json["petName"],
        petBreed: json["petBreed"],
        isSterilization: json["isSterilization"],
        sex: json["sex"],
        birthday: json["birthday"],
        adoptionDate: json["adoptionDate"],
        petKg: json["petKg"],
        age: json["age"],
        isLoss: json["isLoss"],
        isPair: json["isPair"],
        day: json["day"],
        breedId: json["breedId"],
        backgroundUrl: json["backgroundUrl"],
    );

    Map<String, dynamic> toJson() => {
        "petId": petId,
        "petImg": petImg,
        "petName": petName,
        "petBreed": petBreed,
        "isSterilization": isSterilization,
        "sex": sex,
        "birthday": birthday,
        "adoptionDate": adoptionDate,
        "petKg": petKg,
        "age": age,
        "isLoss": isLoss,
        "isPair": isPair,
        "day": day,
        "breedId": breedId,
        "backgroundUrl": backgroundUrl,
    };
}
