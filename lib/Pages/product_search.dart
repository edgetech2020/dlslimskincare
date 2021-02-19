import 'dart:convert';

import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/api/globals.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List product = List();
  ScrollController _scrollController = ScrollController();
  int _rating = 0;
  bool hasMore;
  String msg;
  bool isLoading = false;
  List datah;
  final int defaultPage = 10;
  int i;
  int current;

  @override
  void initState() {
    super.initState();
    debugPrint(pencarian.toString());
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: Appbar.getAppBar(context),
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
                  child: listViewProduct(),
                ),
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

  ListView listViewProduct() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: pencarian?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (pencarian.length < 0) {
            return Center(child: CircularProgressIndicator());
          } else {
            _rating = double.parse(
                    (pencarian.length > 1 && pencarian[index]['ok'] != false)
                        ? pencarian[index]['average_rating'].toString()
                        : "0")
                .round();
            return cardList(context, index);
          }
        });
  }

  Card cardList(BuildContext context, int index) {
    return Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            // splashColor: Color.fromRGBO(32, 59, 141, 1),
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: DetailProductArgument(
                      pencarian[index]['id'],
                      pencarian[index]['name'].toString(),
                      pencarian[index]['images'][0]['src'],
                      pencarian[index]['price'].toString(),
                      double.parse(pencarian[index]['average_rating']),
                      pencarian[index]['description'].toString()));
            },
            child: bodyExtend(context, index),
          ),
        ));
  }

  Column bodyExtend(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 248, 246, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Image.network(
                  (pencarian[index]['ok'] != false && pencarian.length > 1)
                      ? pencarian[index]['images'][0]['src']
                      : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035,
                      left: MediaQuery.of(context).size.width * 0.025),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          (pencarian[index] != null)
                              ? pencarian[index]['name'].toString()
                              : "loading Data",
                          style: ExtraStyle.productTitle()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        (pencarian[index] != null)
                            ? NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(int.parse((pencarian.length > 1 &&
                                        pencarian[index]['ok'] != false)
                                    ? pencarian[index]['price']
                                    : '0'))
                            : "Loading Data",
                        style: ExtraStyle.productTitle(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Text("(" +
                              pencarian[index]['rating_count'].toString() +
                              ")")
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
