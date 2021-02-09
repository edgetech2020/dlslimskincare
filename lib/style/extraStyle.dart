import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExtraStyle {
  static TextStyle styleHeading() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 20);
  }

  static TextStyle styleMore() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 12);
  }

  static TextStyle styleIsi() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(230, 248, 246, 1),
        fontFamily: "MontSerrat",
        fontSize: 12);
  }

  static TextStyle styleProduct() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 12);
  }

  static TextStyle profileUname() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(230, 248, 246, 1),
        fontFamily: "MontSerrat",
        fontSize: 18);
  }

  static TextStyle productTitle() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 16);
  }

  static TextStyle productBuyNow() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 20);
  }

  static Container beautyTreatmen(text) {
    return Container(
        // width: MediaQueryData.fromWindow(window).size.width * 0.5,
        height: MediaQueryData.fromWindow(window).size.height * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) => Card(
                  child: Container(
                      width: MediaQueryData.fromWindow(window).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(32, 59, 141, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text('Beauty Treatment', style: styleIsi()))),
                )));
  }

  static TextStyle profileTextTitle() {
    return const TextStyle(
        // color 203b8d
        color: Color.fromRGBO(32, 59, 141, 1),
        fontFamily: "MontSerrat",
        fontSize: 20);
  }
}
