import 'dart:convert';

import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiNewsPromo {
  static Container apiNewsPromo() {
    List news = List();
    final String url = "https://dashboard.dlslimskincare.com/api/news";

    Future newsPromo() async {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        news = json.decode(response.body) as List;
      }
    }

    return Container(
      child: FutureBuilder(
          future: newsPromo(),
          builder: (context, s) {
            if (s.connectionState == ConnectionState.waiting && !s.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: news.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                decoration: BoxDecoration(
                                    // color: Color.fromRGBO(32, 59, 141, 1),
                                    image: DecorationImage(
                                      image: NetworkImage((news[index]
                                                  ['image'] !=
                                              null)
                                          ? news[index]['image']
                                          : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/detailnews',
                                          arguments: NewsArguments(
                                              news[index]['title'].toString(),
                                              news[index]['content'].toString(),
                                              news[index]['image']));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(40, 40, 40, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                          child: Text(news[index]['title'],
                                              textAlign: TextAlign.center,
                                              style: ExtraStyle.styleIsi())),
                                    ),
                                  ),
                                )),
                          )));
          }),
    );
  }
}
