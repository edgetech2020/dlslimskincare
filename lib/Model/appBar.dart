import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dlslim/Model/globals.dart' as globals;

class Appbar {
  static getAppBar(BuildContext context) {
    return AppBar(
      title: Container(
        height: MediaQueryData.fromWindow(window).size.height * 0.04,
        child: TextField(
          obscureText: false,
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
      backgroundColor: Colors.blue,
      elevation: 0.0,
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: MediaQueryData.fromWindow(window).size.width * 0.05),
          child: Icon(
            Icons.favorite,
            color: Colors.black,
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
                color: Colors.black,
              ),
              if (globals.cartList.length > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      globals.cartList.length.toString(),
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
