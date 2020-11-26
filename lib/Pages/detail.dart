// import 'dart:convert';
// import 'dart:html';

import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/argument.dart';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:dlslim/Model/globals.dart' as globals;
// import 'dart:async';
// import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final DetailProductArgument arguments;
  DetailPage(this.arguments);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int id;
  int nId = 0;

  // List product = List();

  // Future<void> productDetail(String id) async {
  //   final respon = await http
  //       .get("https://dashboard.dlslimskincare.com/api/products/reviews/" + id);

  //   if (respon.statusCode == 200) {
  //     product = json.decode(respon.body) as List;
  //     // print(product);
  //   } else {
  //     throw Exception('failed to load json');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   productDetail(widget.arguments.id).then((_) {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(color: Color.fromRGBO(226, 225, 225, 0.1)),
        child: SafeArea(
          right: true,
          left: false,
          bottom: false,
          top: true,
          child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.05),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3,
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
                                    // Padding(
                                    //     padding: EdgeInsets.only(
                                    //         right: MediaQuery.of(context)
                                    //                 .size
                                    //                 .width *
                                    //             0.3)),
                                    Icon(
                                      Icons.favorite_outline,
                                      size: 45,
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
                                    ExtraStyle.beautyTreatmen(Card()),
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
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.8),
                right: (MediaQuery.of(context).size.width * 0.13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: RaisedButton(
                        child: Text(
                          "+ Keranjang",
                          style:
                              TextStyle(color: Color.fromRGBO(32, 59, 141, 1)),
                        ),
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/rumah');

                          globals.cartList.add(widget.arguments.id);
                          setState(() {});
                        },
                        color: Color.fromRGBO(139, 223, 215, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: RaisedButton(
                        child: Text(
                          "Beli Sekarang",
                          style:
                              TextStyle(color: Color.fromRGBO(32, 59, 141, 1)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/buynow',
                              arguments: BuyNowArg(
                                  widget.arguments.id,
                                  widget.arguments.name,
                                  widget.arguments.foto,
                                  int.parse(widget.arguments.harga)));
                        },
                        color: Color.fromRGBO(139, 223, 215, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
