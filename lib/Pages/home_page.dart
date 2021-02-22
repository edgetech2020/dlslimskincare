import 'dart:async';

import 'package:dlslim/Model/m_beautyTreatment.dart';
import 'package:dlslim/Model/m_carousel.dart';
import 'package:dlslim/Model/m_newsPromo.dart';
import 'package:dlslim/Model/m_product.dart';
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/Pages/newPromo.dart';
import 'package:dlslim/Pages/product.dart';
import 'package:dlslim/Pages/treamentall.dart';
import 'package:dlslim/api/globals.dart';
import 'package:dlslim/api/testget.dart';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _loaded = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) async {
      // setState(() {
      debugPrint(idUser.toString());
      if (_loaded != true) {
        loadingAction();
      }
      TestGetApi.getListCart(context).then((value) {
        setState(() {
          _loaded = true;
          if (_loaded == true) {
            Navigator.pop(context);
          }
        });
      });
      // });
    });
    LoadUP.getUP().then((value) {
      up = username;
      ap = password;
      debugPrint('UP : ' + up);
      setState(() {});
    });
  }

  loadingAction() {
    showDialog(
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

  _launchURL() async {
    const url = 'https://dlslimskincare.com/appointment/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    void goToNews() {
      // () {
      Get.to(NewsPromo());
      // }
    }

    void goToProduct() {
      Get.to(Product());
    }

    List<Widget> loadChildren() {
      if (homeLoaded) {
        return homeWidgets;
      } else {
        homeLoaded = true;
        homeWidgets = [
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
                      onPressed: goToNews,
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
                      onPressed: goToProduct,
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
                      onPressed: _launchURL,
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
        ];
        return homeWidgets;
      }
    }

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: ListView(
                children: (_loaded ? loadChildren() : [Container()]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
