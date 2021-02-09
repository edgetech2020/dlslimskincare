import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Hal extends StatefulWidget {
  @override
  HalState createState() => HalState();
}

class HalState extends State<Hal> {
  bool buttonDis = true;
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/Background Login dan Sign Up1.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.05,
              child: RaisedButton(
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Hexcolor('#e6f8f6'), fontSize: 22),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/loginpage');
                },
                color: Hexcolor('#4C8CA7'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Hexcolor('#4C8CA7'), width: 2),
                  borderRadius: BorderRadius.circular(18)),
              child: RaisedButton(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Hexcolor('#4C8CA7'), fontSize: 22),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/registrasi');
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                  text: TextSpan(
                      text: 'By Login or Register, you agree to our \n',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(color: Hexcolor('#4C8CA7'))),
                    TextSpan(
                        text: ' & ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: Hexcolor('#4C8CA7')))
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
