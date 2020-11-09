import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class GenderSex extends StatefulWidget {
  @override
  _GenderSexState createState() => _GenderSexState();
}

class _GenderSexState extends State<GenderSex> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ResponsiveFlutter.of(context).wp(100),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/utama.png"),
          fit: BoxFit.cover,
        )),
        child: Container(
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      "Halo",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: ResponsiveFlutter.of(context).hp(10),
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      "Nindi Rizkia Putri.",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: ResponsiveFlutter.of(context).hp(5),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      "Terima kasih telah mendaftar data diri anda di aplikasi kami Selanjutnya silahkan mengisi data diri anda untuk melanjuti",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: ResponsiveFlutter.of(context).hp(1.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Hexcolor(
                              '#203b8d',
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => setState(() => _value = 1),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: _value == 1
                                          ? Hexcolor('#203b8d')
                                          : Colors.transparent,
                                      width: 5),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(105, 170, 175, 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ],
                                  color: Colors.white),
                              child: Image.asset('assets/images/pria.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Hexcolor('#203b8d'),
                        ),
                        child: GestureDetector(
                          onTap: () => setState(() => _value = 0),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: _value == 0
                                        ? Hexcolor('#203b8d')
                                        : Colors.transparent,
                                    width: 5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(105, 170, 175, 0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ],
                                color: Colors.white),
                            child: Image.asset('assets/images/wanita.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.14),
                          // width: MediaQuery.of(context).size.width * 1,
                          // height: MediaQuery.of(context).size.height * 1,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              "Terima kasih telah mengisi data diri anda ")),
                    ],
                  ),
                  RaisedButton(
                    child: Text(
                      "Selanjutnya",
                      style: TextStyle(color: Hexcolor('#e6f8f6')),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/camera');
                    },
                    color: Color.fromRGBO(0, 0, 104, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
