import 'package:dlslim/Model/appBar.dart';
import 'package:flutter/material.dart';
import 'package:dlslim/Model/globals.dart' as globals;

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  String hasil;
  int prevId = 0;
  int counterL = 0;
  bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: Stack(
        children: [
          Center(
              child: Container(
            child: ListView.builder(
                itemCount: globals.cartList.length,
                itemBuilder: (context, int index) {
                  hasil = globals.cartList[index].toString();
                  if (globals.cartList[index] == prevId) {
                    // hasil = hasil + "(" + counterL.toString() + ")";
                    hasil = globals.cartList[index].toString();
                    counterL++;
                    isEmpty = false;
                  } else {
                    hasil = "no";
                    isEmpty = true;
                    prevId = -1;
                    counterL = 0;
                  }
                  prevId = globals.cartList[index];
                  return Card(
                    child: isEmpty ? null : Text(hasil),
                  );
                }),
          )),
          Center(
            child: Container(
              width: 250.0,
              child: RaisedButton(
                child: Text(
                  "LogOut",
                  style: TextStyle(color: Color.fromRGBO(230, 248, 246, 1)),
                ),
                onPressed: () {
                  globals.cartList.clear();
                  setState(() {});
                },
                color: Color.fromRGBO(0, 0, 104, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
