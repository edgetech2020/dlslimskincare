import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenderSex extends StatefulWidget {
  @override
  _GenderSexState createState() => _GenderSexState();
}

class _GenderSexState extends State<GenderSex> {
  int _value = 0;
  String uname;
  int genderhsl;
  String hsl;
  String genderHsl;

  void initState() {
    super.initState();
    getUsername().then((value) {
      setState(() {});
    });
  }

  Future setGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('gender', _value);
  }

  Future getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    uname = pref.getString('uname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ResponsiveFlutter.of(context).wp(100),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/Background Personal Info1.jpg"),
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
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      "Hai,",
                      style: GoogleFonts.roboto(
                          color: Color(0xff4C8CA7),
                          fontSize: ResponsiveFlutter.of(context).hp(6)),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      uname ?? '',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: ResponsiveFlutter.of(context).hp(6),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4C8CA7),
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
                                          ? Hexcolor('#4C8CA7')
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
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Image.asset(
                                  'assets/images/pria_1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
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
                                        ? Hexcolor('#4C8CA7')
                                        : Colors.transparent,
                                    width: 5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(105, 170, 175, 0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ],
                                color: Colors.white),
                            child: Image.asset('assets/images/bencong.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      child: Text(
                        "Selanjutnya",
                        style: TextStyle(color: Hexcolor('#e6f8f6')),
                      ),
                      onPressed: () {
                        setGender();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => CameraPage()));
                        Navigator.pushNamed(context, '/camera');
                      },
                      color: Hexcolor('#4C8CA7'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  // RaisedButton(
                  //   child: Text(
                  //     "load",
                  //     style: TextStyle(color: Hexcolor('#e6f8f6')),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       loadGender();
                  //     });
                  //     // Navigator.pushNamed(context, '/camera');
                  //   },
                  //   color: Color.fromRGBO(0, 0, 104, 1),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15)),
                  // ),
                  // Center(
                  //   child: Text(genderHsl ?? ""),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
