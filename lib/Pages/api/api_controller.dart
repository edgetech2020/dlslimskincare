import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

//get API

// List list = List();

class GetApi {
  String data;

  GetApi({this.data});

  factory GetApi.createGetApi(Map<String, dynamic> parsedJson) {
    return GetApi(
      data: parsedJson['data'].toString(),
    );
  }
  static Future<void> connectAPI() async {
    String apiURL = "https://dashboard.dlslimskincare.com/api/banners";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>);

    return GetApi.createGetApi(userData);
  }
}
