// To parse this JSON data, do
//
//     final maslakModel = maslakModelFromJson(jsonString);

import 'dart:convert';

List<MaslakModel> maslakModelFromJson(String str) => List<MaslakModel>.from(
    json.decode(str).map((x) => MaslakModel.fromJson(x)));

String maslakModelToJson(List<MaslakModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaslakModel {
  MaslakModel({
    this.mId,
    this.name,
  });

  int mId;
  String name;

  factory MaslakModel.fromJson(Map<String, dynamic> json) => MaslakModel(
        mId: json["mId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mId": mId,
        "name": name,
      };
}
