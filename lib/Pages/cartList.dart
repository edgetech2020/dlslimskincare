import 'dart:convert';

import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/Model/webviewCheckOut.dart';
import 'package:dlslim/api/testget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dlslim/api/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  String hasil;
  int prevId = 0;
  int counterL = 0;
  bool isEmpty;
  Map idUser;
  Map cart;
  List cartList;

  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      setState(() {
        TestGetApi.getListCart(context).then((value) {
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: Stack(
        children: [
          Center(
              child: Container(
            child: ListView.builder(
                itemCount: globals.cartId?.length ?? 0,
                itemBuilder: (context, int index) {
                  return Card(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        globals.imagenot ?? globals.imagenot))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(globals.cartId[index]['product_name']
                                  .toString()),
                              Text('Qty :' +
                                  ' ' +
                                  globals.cartId[index]['quantity'].toString()),
                              Text((globals.cartId[index]['product_price'] !=
                                      null)
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(globals.cartId[index]
                                              ['product_price'] *
                                          globals.cartId[index]['quantity'])
                                      .toString()
                                  : '')
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )),
          Positioned(
            top: height * 0.75,
            left: width * 0.15,
            child: Container(
              width: width * 0.7,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CheckOut()));
                },
                child: Text(
                  'Beli Sekarang',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
