import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

//get API

// List list = List();

class NewsApi {
  String title, content, image;

  NewsApi({this.title, this.content, this.image});

  factory NewsApi.createGetApi(Map<String, dynamic> object) {
    return NewsApi(
        title: object["title"],
        content: object["content"],
        image: object["image"]);
  }
  static Future<List<NewsApi>> connectAPI() async {
    String apiURL = "https://dashboard.dlslimskincare.com/api/news";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<NewsApi>((item) => NewsApi(
            title: item["title"],
            content: item["content"],
            image: item["image"]))
        .toList();
  }
}

class NewsNew {
  // List<NewsNew> listi = List();
  // String title, content, image;

  // NewsNew({this.title, this.content, this.image});

  // factory NewsNew.createGetApi(Map<String, dynamic> object) {
  //   return NewsNew(
  //       title: object['title'].toString(),
  //       content: object['content'],
  //       image: object['image']);
  // }
  static Future fetchData() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/news");
    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      var listi = json.decode(response.body) as List;
      // return listi.map<NewsNew>((e) => NewsNew(title: e['title']));
      return listi;
    }
  }
}
