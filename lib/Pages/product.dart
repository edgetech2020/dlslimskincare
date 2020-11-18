import 'dart:convert';
import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List product = List();
  int _rating = 0;
  Future productData() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/products/");
    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      product = json.decode(response.body) as List;
      return product;
    } else {
      throw Exception('failed to load json');
    }
  }

  @override
  void initState() {
    super.initState();
    productData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: FutureBuilder(
                        future: productData(),
                        builder: (context, AsyncSnapshot s) {
                          if (s.connectionState == ConnectionState.waiting &&
                              !s.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: product.length,
                                itemBuilder: (BuildContext context, int index) {
                                  _rating = double.parse(
                                          product[index]['average_rating'])
                                      .round();
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
                                                arguments: ScreenArguments(
                                                    product[index]['id'],
                                                    product[index]['name']
                                                        .toString(),
                                                    product[index]['images'][0]
                                                        ['src'],
                                                    product[index]['price']
                                                        .toString(),
                                                    double.parse(product[index]
                                                        ['average_rating']),
                                                    product[index]
                                                            ['description']
                                                        .toString()));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              230, 248, 246, 1),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(25),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      25))),
                                                      child: Image.network(
                                                        (product[index] != null)
                                                            ? product[index]
                                                                    ['images']
                                                                [0]['src']
                                                            : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png',
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
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
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.035,
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.025),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                (product[index] !=
                                                                        null)
                                                                    ? product[index]
                                                                            [
                                                                            'name']
                                                                        .toString()
                                                                    : "loading Data",
                                                                style: ExtraStyle
                                                                    .productTitle()),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.01,
                                                            ),
                                                            Text(
                                                              (product[index] !=
                                                                      null)
                                                                  ? NumberFormat.currency(
                                                                          locale:
                                                                              'id',
                                                                          symbol:
                                                                              'Rp. ',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(int.parse(
                                                                          product[index]
                                                                              [
                                                                              'price']))
                                                                  : "Loading Data",
                                                              style: ExtraStyle
                                                                  .productTitle(),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.01,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: (_rating >=
                                                                          1)
                                                                      ? Color.fromRGBO(
                                                                          32,
                                                                          59,
                                                                          141,
                                                                          1)
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: (_rating >=
                                                                          2)
                                                                      ? Color.fromRGBO(
                                                                          32,
                                                                          59,
                                                                          141,
                                                                          1)
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: (_rating >=
                                                                          3)
                                                                      ? Color.fromRGBO(
                                                                          32,
                                                                          59,
                                                                          141,
                                                                          1)
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: (_rating >=
                                                                          4)
                                                                      ? Color.fromRGBO(
                                                                          32,
                                                                          59,
                                                                          141,
                                                                          1)
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: (_rating >=
                                                                          5)
                                                                      ? Color.fromRGBO(
                                                                          32,
                                                                          59,
                                                                          141,
                                                                          1)
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                Text("(" +
                                                                    product[index]
                                                                            [
                                                                            'rating_count']
                                                                        .toString() +
                                                                    ")")
                                                              ],
                                                            ),
                                                          ],
                                                        ))
                                                  ],
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
