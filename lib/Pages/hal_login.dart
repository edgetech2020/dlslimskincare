import 'package:dlslim/Pages/gender.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'camera.dart';

class Hal extends StatefulWidget {
  @override
  HalState createState() => HalState();
}

class HalState extends State<Hal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // top: true,
        bottom: true,
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/utama.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Hero(
                    tag: Hal(),
                    child: Image(image: AssetImage('assets/images/logo.png'))),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Welcome To DL Slim Skin Care',
                      style: ExtraStyle.styleHeading())),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Hexcolor('#e6f8f6')),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginpage');
                  },
                  color: Color.fromRGBO(0, 0, 104, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  child: Text(
                    "Daftar",
                    style: TextStyle(color: Hexcolor('#e6f8f6')),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registrasi');
                  },
                  color: Color.fromRGBO(0, 0, 104, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  child: Text(
                    "Test 1",
                    style: TextStyle(color: Hexcolor('#e6f8f6')),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GenderSex()));
                  },
                  color: Color.fromRGBO(0, 0, 104, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
