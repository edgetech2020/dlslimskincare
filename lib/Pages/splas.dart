import 'package:dlslim/Pages/hal_login.dart';
import 'package:flutter/material.dart';

import 'dart:async';

// import 'login_new.dart';

class Splashscreen extends StatefulWidget {
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Hal()),
      );
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
