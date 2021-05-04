import 'dart:convert';

import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Product extends StatefulWidget {
  final int id;
  Product({this.id});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List product = List();
  ScrollController _scrollController = ScrollController();
  int _rating = 0;
  bool hasMore;
  int _pageNumber = 1;
  String msg;
  bool isLoading = false;
  List datah;
  final int defaultPage = 10;
  int i;
  int current;

  @override
  void initState() {
    print('yuyuuyuyuyuyu');

    try {
      this.productData(_pageNumber);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // loadingAction();
          productData(_pageNumber);
        }
      });
    } catch (e) {}

    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  loadingAction() {
    showDialog(
        useSafeArea: false,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future productData(int index) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://dashboard.dlslimskincare.com/products/list-category'));
    request.fields.addAll(
        {'category': widget.id.toString(), 'page_number': index.toString()});

    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    product = json.decode(result);
    // List tList = new List();
    // datah = json.decode(result) as List;

    // for (i = 0; i <= datah.length; i++) {
    //   tList.add(datah[i]);
    // }
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // setState(() {
      //   isLoading = false;

      //   current = i;
      //   product.addAll(tList);
      //   _pageNumber++;
      // });
    } else {
      print(response.reasonPhrase);
      // Fluttertoast.showToast(msg: 'No Data Available');
    }
  }

  // Future productData(int index) async {
  //   // Fluttertoast.showToast(msg: "called");
  //   try {
  //     if (!isLoading) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       final response = await http.get(
  //           'https://dashboard.dlslimskincare.com/api/products/' +
  //               index.toString());
  //       List tList = new List();
  //       datah = json.decode(response.body) as List;

  //       for (i = 0; i <= datah.length - 1; i++) {
  //         tList.add(datah[i]);
  //       }

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           isLoading = false;

  //           current = i;
  //           product.addAll(tList);
  //           _pageNumber++;
  //         });
  //       } else {
  //         debugPrint('test full');
  //         Fluttertoast.showToast(msg: 'No Data Available');
  //       }
  //     }
  //     if (isLoading == true) {
  //       loadingAction();
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      appBar: Appbar.getAppBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(),
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
                        future: productData(_pageNumber).then((value) {
                          debugPrint(product.toString());
                          setState(() {});
                        }),
                        builder: (ctx, s) {
                          if (s.connectionState == ConnectionState.waiting &&
                              !s.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return listViewProduct();
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

  ListView listViewProduct() {
    return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: product?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (product.length < 0) {
            return Center(child: CircularProgressIndicator());
          } else {
            _rating = double.parse(
                    (product.length > 1 && product[index]['ok'] != false)
                        ? product[index]['average_rating'].toString()
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
                      product[index]['id'],
                      product[index]['name'].toString(),
                      product[index]['images'][0]['src'],
                      product[index]['price'].toString(),
                      double.parse(product[index]['average_rating']),
                      product[index]['description'].toString()));
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
                  (product[index]['ok'] != false && product.length > 1)
                      ? product[index]['images'][0]['src']
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
                          (product[index] != null)
                              ? product[index]['name'].toString()
                              : "loading Data",
                          style: ExtraStyle.productTitle()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        (product[index] != null)
                            ? NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(int.parse((product.length > 1 &&
                                        product[index]['ok'] != false)
                                    ? product[index]['price']
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
                              product[index]['rating_count'].toString() +
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
