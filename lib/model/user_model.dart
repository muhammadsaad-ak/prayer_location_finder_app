// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.name,
    this.lat,
    this.long,
    this.isMasjidRepresentative,
    this.contactNo,
    this.mId,
    this.pId,
  });

  String name;
  String lat;
  String long;
  bool isMasjidRepresentative;
  int contactNo;
  int mId;
  int pId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        lat: json["lat"],
        long: json["long"],
        isMasjidRepresentative: json["isMasjidRepresentative"],
        contactNo: json["contactNo"],
        mId: json["mId"],
        pId: json["pId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "long": long,
        "isMasjidRepresentative": isMasjidRepresentative,
        "contactNo": contactNo,
        "mId": mId,
        "pId": pId,
      };
}
