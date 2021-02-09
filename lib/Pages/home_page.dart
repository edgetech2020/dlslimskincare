import 'dart:async';

import 'package:dlslim/Model/m_beautyTreatment.dart';
import 'package:dlslim/Model/m_carousel.dart';
import 'package:dlslim/Model/m_newsPromo.dart';
import 'package:dlslim/Model/m_product.dart';
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/Pages/treamentall.dart';
import 'package:dlslim/api/testget.dart';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  bool isLogin = true;
  Map cart;
  Map idUser;
  List cartList;
  bool isLogOut = false;

  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      setState(() {
        debugPrint(idUser.toString());
        TestGetApi.getListCart().then((value) {
          setState(() {});
        });
      });
    });
  }

  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    content: Text('Tekan dua kali untuk keluar'),
    duration: snackBarDuration,
  );

  DateTime backButtonPressTime;
  Future<bool> onWillPop(BuildContext context) async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home.png"),
                  fit: BoxFit.cover)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                ApiCarousel.apiCarousel(),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "News & Promo",
                            style: ExtraStyle.styleHeading(),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/news');
                            },
                            child: Text(
                              'Lihat Semua',
                              style: ExtraStyle.styleMore(),
                            ),
                          ),
                        ],
                      ),
                      ApiNewsPromo.apiNewsPromo(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product",
                            style: ExtraStyle.styleHeading(),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/product');
                            },
                            child: Text(
                              'Lihat Semua',
                              style: ExtraStyle.styleMore(),
                            ),
                          ),
                        ],
                      ),
                      ApiProduct.apiProduct(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Beauty Treatment",
                            style: ExtraStyle.styleHeading(),
                          ),
                          FlatButton(
                            onPressed: () {
                              Get.to(AllTreatment());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Test()));
                            },
                            child: Text(
                              'Lihat Semua',
                              style: ExtraStyle.styleMore(),
                            ),
                          ),
                        ],
                      ),
                      ApiBeautyTreatment.apiBeautyTreatment(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
