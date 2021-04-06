// import 'dart:convert';
// import 'package:prayer_location_finder_app/model/apiinfo.dart';
// import 'package:http/http.dart' as http;
// import 'package:prayer_location_finder_app/constants/strings.dart';
//
// class API_Manager {
//   Future<PrayArea> getData() async {
//     var client = http.Client();
//     var prayArea = null;
//
//     try {
//       var response = await client.get(Strings.api_url);
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);
//
//         prayArea = PrayArea.fromJson(jsonMap);
//       }
//     } catch (Exception) {
//       return prayArea;
//     }
//     return prayArea;
//   }
//
//   Future<PrayArea> postData() async {
//     var client = http.Client();
//     var prayArea = null;
//
//     try {
//       var response = await client.post(Strings.api_url);
//       if (response.statusCode == 201) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);
//
//         prayArea = PrayArea.fromJson(jsonMap);
//       }
//     } catch (Exception) {
//       return prayArea;
//     }
//     return prayArea;
//   }
// }
