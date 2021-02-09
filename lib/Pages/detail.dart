import 'dart:convert';
import 'dart:ui';

import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/testget.dart';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dlslim/api/globals.dart' as globals;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final DetailProductArgument arguments;
  DetailPage(this.arguments);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int id;
  int nId = 0;
  String username;
  String password;
  List product = List();

  @override
  void initState() {
    super.initState();
    getUP().then((value) {
      setState(() {});
    });
    productDetail().then((_) {
      setState(() {});
    });
    ShareAll.getUserID().then((value) {
      setState(() {});
    });
  }

  Future getUP() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString('username');
    password = pref.getString('password');
  }

  Future addToCart() async {
    try {
      var url = 'https://dlslimskincare.com/wp-json/cocart/v1/add-item';
      http.post(url, body: {
        'product_id': widget.arguments.id.toString(),
        'quantity': '1'
      }, headers: {
        "Authorization":
            "Basic " + base64.encode(utf8.encode(username + ":" + password))
      }).then((http.Response response) {
        Map test1 = json.decode(response.body);
        if (response.statusCode == 200) {
          setState(() {
            Fluttertoast.showToast(msg: 'Item Telah Ditambah Kekeranjang');
          });
        } else {
          Fluttertoast.showToast(msg: test1['message'].toString() ?? '');
          debugPrint('gagal');
        }
      });
    } catch (e) {}
  }

  Future<void> productDetail() async {
    final respon = await http.get(
        "https://dashboard.dlslimskincare.com/api/products/reviews/" +
            widget.arguments.id.toString());

    if (respon.statusCode == 200) {
      product = json.decode(respon.body) as List;
      // print(product);
    } else {
      throw Exception('failed to load json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: Appbar.getAppBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(color: Color.fromRGBO(226, 225, 225, 0.1)),
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.05),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: Color.fromRGBO(32, 59, 141, 0.8),
                  image: DecorationImage(
                      image: NetworkImage((widget.arguments.foto != null)
                          ? widget.arguments.foto
                          : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                      scale: 2.5)),
            ),
            Positioned.fill(
              child: SafeArea(
                right: true,
                left: false,
                bottom: false,
                top: true,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  maxChildSize: 0.9,
                  minChildSize: 0.7,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(230, 248, 246, 1),
                          borderRadius: BorderRadius.circular(40)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.arguments.name,
                                          style: ExtraStyle.productTitle(),
                                        ),
                                        Text(
                                          (widget.arguments.harga != null)
                                              ? NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp. ',
                                                      decimalDigits: 0)
                                                  .format(int.parse(
                                                      widget.arguments.harga))
                                              : 'data not found',
                                          style: ExtraStyle.productTitle(),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        debugPrint('test');
                                        GetWhislist.getColor(
                                                widget.arguments.id.toString())
                                            .then((value) {
                                          setState(() {});
                                          Fluttertoast.showToast(
                                              msg: globals
                                                  .colorChange['message']);
                                        });
                                      },
                                      child: Icon(
                                          ((globals.colorChange != null) &&
                                                  globals.colorChange[
                                                          'is_added'] ==
                                                      true)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 45,
                                          color:
                                              Color.fromRGBO(32, 59, 141, 1)),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                'Dekripsi',
                                style: ExtraStyle.styleHeading(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  child: Html(
                                    data: widget.arguments.deskripsi,
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.7),
                                child: Text(
                                  'Rating',
                                  style: ExtraStyle.styleHeading(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.55,
                                    top: MediaQuery.of(context).size.width *
                                        0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ((widget.arguments.rating > 0
                                                  ? widget.arguments.rating
                                                  : 0) >=
                                              1)
                                          ? Color.fromRGBO(32, 59, 141, 1)
                                          : Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: ((widget.arguments.rating > 0
                                                  ? widget.arguments.rating
                                                  : 0) >=
                                              2)
                                          ? Color.fromRGBO(32, 59, 141, 1)
                                          : Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: ((widget.arguments.rating > 0
                                                  ? widget.arguments.rating
                                                  : 0) >=
                                              3)
                                          ? Color.fromRGBO(32, 59, 141, 1)
                                          : Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: ((widget.arguments.rating > 0
                                                  ? widget.arguments.rating
                                                  : 0) >=
                                              4)
                                          ? Color.fromRGBO(32, 59, 141, 1)
                                          : Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: ((widget.arguments.rating > 0
                                                  ? widget.arguments.rating
                                                  : 0) >=
                                              5)
                                          ? Color.fromRGBO(32, 59, 141, 1)
                                          : Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              // Text(widget.arguments.id.toString()),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Review Pengguna",
                                        style: ExtraStyle.styleHeading(),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Container(
                                        // width: MediaQueryData.fromWindow(window).size.width * 0.5,
                                        height:
                                            MediaQueryData.fromWindow(window)
                                                    .size
                                                    .height *
                                                0.13,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (product.length >= 0
                                                ? product.length
                                                : 1),
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Card(
                                                  child: Container(
                                                      width: MediaQueryData.fromWindow(window)
                                                              .size
                                                              .width *
                                                          0.5,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              32, 59, 141, 1),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15)),
                                                      child: Center(
                                                          child: Text(
                                                              (product[index]['reviewer'] != null
                                                                  ? product[index]
                                                                      ['reviewer']
                                                                  : 'belum ada yang review nih'),
                                                              style: ExtraStyle.styleIsi()))),
                                                ))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.9),
              left: (MediaQuery.of(context).size.width * 0.32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: RaisedButton(
                      child: Text(
                        "+ Keranjang",
                        style: TextStyle(color: Color.fromRGBO(32, 59, 141, 1)),
                      ),
                      onPressed: () {
                        addToCart();
                      },
                      color: Color.fromRGBO(139, 223, 215, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.35,
                  //   child: RaisedButton(
                  //     child: Text(
                  //       "Beli Sekarang",
                  //       style:
                  //           TextStyle(color: Color.fromRGBO(32, 59, 141, 1)),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/buynow',
                  //           arguments: BuyNowArg(
                  //               widget.arguments.id,
                  //               widget.arguments.name,
                  //               widget.arguments.foto,
                  //               int.parse(widget.arguments.harga)));
                  //     },
                  //     color: Color.fromRGBO(139, 223, 215, 1),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15)),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
