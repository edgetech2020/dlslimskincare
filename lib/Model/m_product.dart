import 'dart:ui';

import 'package:dlslim/Pages/detail.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiProduct {
  static Container apiProduct() {
    List list = List();
    double _rating = 0;

    Future fetchData() async {
      final response =
          await http.get("https://dashboard.dlslimskincare.com/api/products/");
      // await Future.delayed(Duration(seconds: 10));
      if (response.statusCode == 200) {
        list = json.decode(response.body) as List;
        return list;
      }
    }

    return Container(
      child: FutureBuilder(
          future: fetchData(),
          builder: (context, s) {
            if (s.connectionState == ConnectionState.waiting && !s.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(
                height: MediaQueryData.fromWindow(window).size.height * 0.4,
                width: MediaQueryData.fromWindow(window).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (list.length > 0 ? 5 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      _rating =
                          double.parse(list[index]['average_rating'] ?? "");
                      return Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                child: new InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/detail',
                                        arguments: ScreenArguments(
                                            list[index]['id'].toString(),
                                            list[index]['name'].toString(),
                                            list[index]['images'][0]['src'],
                                            list[index]['price'].toString(),
                                            double.parse(
                                                list[index]['average_rating']),
                                            list[index]['description']
                                                .toString()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        // color: Colors.red,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(230, 248, 246, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                        ),
                                        child: OverflowBox(
                                          // minHeight: 1,
                                          child: Image.network(
                                            (list.length > 0)
                                                ? list[index]['images'][0]
                                                    ['src']
                                                : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png',
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: Text(
                                            (list.length > 0)
                                                ? list[index]['name'].toString()
                                                : "loading Data",
                                            style: ExtraStyle.styleProduct()),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text(
                                          (list.length > 0)
                                              ? NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(int.parse(
                                                      list[index]['price']))
                                              : "Loading Data",
                                          style: ExtraStyle.styleProduct(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: (_rating >= 1)
                                                ? Color.fromRGBO(32, 59, 141, 1)
                                                : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (_rating >= 2)
                                                ? Color.fromRGBO(32, 59, 141, 1)
                                                : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (_rating >= 3)
                                                ? Color.fromRGBO(32, 59, 141, 1)
                                                : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (_rating >= 4)
                                                ? Color.fromRGBO(32, 59, 141, 1)
                                                : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (_rating >= 5)
                                                ? Color.fromRGBO(32, 59, 141, 1)
                                                : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    }),
              );
          }),
    );
  }
}
