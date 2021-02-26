import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dlslim/Pages/product_search.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:dlslim/api/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class Appbar {
  // static var ppp = TextEditingController();
  static BuildContext dialoCtxt;

  static loading(BuildContext context) {}

  static getAppBar(BuildContext context, {String base64}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 100,
      title: Container(
        height: MediaQueryData.fromWindow(window).size.height * 0.04,
        child: TextField(
          textInputAction: TextInputAction.go,
          // controller: ppp,
          onSubmitted: (value) async {
            await GetProduct.getSearch(
                    context,
                    value,
                    base64Encode(
                        utf8.encode('${globals.username}:${globals.password}')))
                .then((value) async {
              if (value == [] && globals.pencarian != null) {}
              Timer(Duration(milliseconds: 100), () {
                Get.to(Search());
              });
            });
            debugPrint(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              // borderSide: BorderSide(color: Hexcolor('#203b8d')),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Hexcolor('#203b8d')),
                borderRadius: BorderRadius.circular(15)),
            labelText: 'Search',
          ),
        ),
      ),
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: MediaQueryData.fromWindow(window).size.width * 0.05),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/whislist');
            },
            child: Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: MediaQueryData.fromWindow(window).size.width * 0.05),
          child: GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/whislist');
              Fluttertoast.showToast(msg: 'This Feature is Coming Soon');
            },
            child: Icon(
              Icons.chat,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: MediaQueryData.fromWindow(window).size.width * 0.05),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cartlist');
            },
            child: Stack(alignment: Alignment.center, children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
              if ((globals.cartId?.length != null) && globals.cartId.length > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      globals.cartId.length.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ],
    );
  }
}
