import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPromo extends StatefulWidget {
  @override
  _NewsPromoState createState() => _NewsPromoState();
}

class _NewsPromoState extends State<NewsPromo> {
  List news = List();

  Future newsPromoMore() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/news");

    if (response.statusCode == 200) {
      news = json.decode(response.body) as List;
      return news;
    } else {
      throw Exception('failed to load json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    // width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: FutureBuilder(
                        future: newsPromoMore(),
                        builder: (context, AsyncSnapshot s) {
                          if (s.connectionState == ConnectionState.waiting &&
                              !s.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: news.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // splashColor: Color.fromRGBO(32, 59, 141, 1),
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context, '/detail',
                                              // arguments: ScreenArguments(
                                              //     product[index]['id']
                                              //         .toString(),
                                              //     product[index]['name']
                                              //         .toString(),
                                              //     product[index]['images'][0]
                                              //         ['src'],
                                              //     product[index]['price']
                                              //         .toString(),
                                              //     double.parse(product[index]
                                              //         ['average_rating']),
                                              //     product[index]
                                              //             ['description']
                                              //         .toString()));
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                child: Image(
                                                  image: NetworkImage((news[
                                                              index]['image'] !=
                                                          null
                                                      ? news[index]['image']
                                                      : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png')),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05),
                                                  child: Column(
                                                    children: [
                                                      Text(news[index]['title']
                                                          .toString()),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10)),
                                                      Text('Read More >>>')
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                });
                        })),
                SizedBox(
                  height: 250,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
