// // To parse this JSON data, do
// //
// //     final prayArea = prayAreaFromJson(jsonString);
//
// import 'dart:convert';
//
// List<PrayArea> prayAreaFromJson(String str) =>
//     List<PrayArea>.from(json.decode(str).map((x) => PrayArea.fromJson(x)));
//
// String prayAreaToJson(List<PrayArea> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PrayArea {
//   PrayArea({
//     this.pId,
//     this.name,
//     this.lat,
//     this.long,
//     this.ablutionFacility,
//     this.washroomFacility,
//     this.chairFacility,
//     this.groundFloorFacility,
//     this.publiclyAvailable,
//     this.mId,
//     this.uId,
//   });
//
//   int pId;
//   String name;
//   String lat;
//   String long;
//   bool ablutionFacility;
//   bool washroomFacility;
//   bool chairFacility;
//   bool groundFloorFacility;
//   bool publiclyAvailable;
//   int mId;
//   int uId;
//
//   factory PrayArea.fromJson(Map<String, dynamic> json) => PrayArea(
//         pId: json["pId"],
//         name: json["name"],
//         lat: json["lat"],
//         long: json["long"],
//         ablutionFacility: json["ablutionFacility"],
//         washroomFacility: json["washroomFacility"],
//         chairFacility: json["chairFacility"],
//         groundFloorFacility: json["groundFloorFacility"],
//         publiclyAvailable: json["publiclyAvailable"],
//         mId: json["mId"],
//         uId: json["uId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "pId": pId,
//         "name": name,
//         "lat": lat,
//         "long": long,
//         "ablutionFacility": ablutionFacility,
//         "washroomFacility": washroomFacility,
//         "chairFacility": chairFacility,
//         "groundFloorFacility": groundFloorFacility,
//         "publiclyAvailable": publiclyAvailable,
//         "mId": mId,
//         "uId": uId,
//       };
// }
