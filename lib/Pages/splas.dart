import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dlslim/Model/bottomnavbar.dart';

import 'package:dlslim/Pages/hal_login.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// import 'login_new.dart';

class Splashscreen extends StatefulWidget {
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  // ignore: cancel_subscriptions
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";
  bool isLogin = true;
  // bool status;
  Future userLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.get('isLogin') ?? false;
    if (isLogin) {
      Get.off(BottomNavBar());
    } else {
      Get.off(Hal());
    }
  }

  void initState() {
    super.initState();

    splashscreenStart(context);
    // Konek.checkConnection(context);
  }

  void dispose() {
    super.dispose();
    listener.cancel();
  }

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Internet Status"),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: new Text("Ok"))
              ]);
        });
  }

  splashscreenStart(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          userLogin();
          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "Kamu terputus dari internet. ";
          contentmessage = "Harap periksa koneksi internet anda";
          _showDialog(internetStatus, contentmessage, context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Hexcolor('#e6f8f6'),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Loading.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Hero(
              //     tag: Hal(),
              //     child: Image(image: AssetImage('assets/images/logo.png'))),

              // Icon(
              //   Icons.local_hospital_rounded,
              //   size: 100.0,
              //   color: Hexcolor('#203b8d'),
              // ),
              SizedBox(
                height: 24.0,
              ),
              // Text(
              //   "DL Slim Skin Care",
              //   style: TextStyle(
              //     color: Hexcolor('#203b8d'),
              //     fontWeight: FontWeight.bold,
              //     fontSize: 30.0,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
