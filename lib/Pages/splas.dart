import 'package:dlslim/Pages/hal_login.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// import 'login_new.dart';

class Splashscreen extends StatefulWidget {
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  bool isLogin = true;
  // bool status;
  Future userLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.get('isLogin') ?? false;
    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/rumah');
    } else {
      Navigator.pushReplacementNamed(context, '/hal');
    }
  }

  void initState() {
    super.initState();
    splashscreenStart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      userLogin();
    });
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
                image: AssetImage('assets/images/utama.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                  tag: Hal(),
                  child: Image(image: AssetImage('assets/images/logo.png'))),

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
