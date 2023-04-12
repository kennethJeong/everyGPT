// import 'dart:convert';
// import 'dart:io';
// import 'package:challenges_bt/api/object.dart';
// import 'package:http/http.dart' as http;
//
// Future<List<JsonObject>> getRequest(String url) async {
//   // Header - Authorization
//   String authorizationHeader = '3b17176f2eb5fdffb9bafdcc3e4bc192b013813caddccd0aad20c23ed272f076_1423639497';
//
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       HttpHeaders.authorizationHeader: authorizationHeader,
//     },
//   );
//
//   if (response.statusCode == HttpStatus.ok) {
//     var jsonList = jsonDecode(response.body);
//     final jsonListData = jsonList['data'] as List;
//
//     final items = jsonListData.cast<Map<String, dynamic>>();
//
//     // Transforming to List
//     List<JsonObject> allInfo = items.map<JsonObject>((json) {
//       return JsonObject.fromJson(json);
//     }).toList();
//
//     return allInfo;
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
