import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Concern extends StatefulWidget {
  @override
  _ConcernState createState() => _ConcernState();
}

class _ConcernState extends State<Concern> {
  var _skin = [];
  var _body = [];
  var _hair = [];
  int gender;
  String tampakDepanBase64;
  String tampakKananBase64;
  String tampakKiriBase64;
  int tipe;
  int warna;
  int dasar;
  int rambut;
  int warnaRambut;
  int hijab;
  Map uid;
  int value;
  String msg;
  Map rspns;

  @override
  void initState() {
    super.initState();
    loadAPI().then((_) {
      setState(() {});
    });
  }

  Future loadAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    gender = pref.getInt('gender');
    tampakDepanBase64 = pref.getString('depan');
    tampakKananBase64 = pref.getString('kanan');
    tampakKiriBase64 = pref.getString('kiri');
    value = pref.getInt('tipeKulitWajah');
    tipe = pref.getInt('tipe');
    warna = pref.getInt('warna');
    dasar = pref.getInt('dasar');
    rambut = pref.getInt('rambut');
    warnaRambut = pref.getInt('warna_rambut');
    hijab = pref.getInt('hijab');
    uid = json.decode(pref.getString('regist'));
  }

  Future postQuestion() async {
    var url = 'https://dashboard.dlslimskincare.com/api/user-meta';
    http.post(url, body: {
      'uid': uid['user_id'].toString(),
      'depan_base64_image': tampakDepanBase64?.substring(
              (tampakDepanBase64.indexOf(",")) + 1, tampakDepanBase64.length) ??
          '',
      'kanan_base64_image': tampakKananBase64?.substring(
              (tampakKananBase64.indexOf(",")) + 1, tampakKananBase64.length) ??
          '',
      'kiri_base64_image': tampakKiriBase64?.substring(
              (tampakKiriBase64.indexOf(",")) + 1, tampakKiriBase64.length) ??
          '',
      'gender': gender.toString(),
      'face_skin_cond': value.toString(),
      'skin_type': tipe.toString(),
      'skin_color': warna.toString(),
      'base_skin_color': dasar.toString(),
      'hair_type': rambut.toString(),
      'is_colored_hair': warnaRambut.toString(),
      'is_hijaber': hijab.toString(),
      'skin_concern': json.encode(_skin).toString(),
      'body_concern': json.encode(_body).toString(),
      'hair_concern': json.encode(_hair).toString(),
    }).then((http.Response response) {
      rspns = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Data berhasil di store');
        // Navigator.pushNamed(context, '/rumah');
      } else {
        setState(() {
          Fluttertoast.showToast(msg: rspns['message']);
          msg = rspns['message'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/utama.png"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                  child: Text(
                "Complete your beauty ID",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(3)),
              )),
            ),
            // Text(uid.toString()),
            //skin concern
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "Skin Concern",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.7)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text("kamu bisa pilih salah satu"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(0) ? _skin.remove(0) : _skin.add(0)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(0)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Bekas Jerawat",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(1) ? _skin.remove(1) : _skin.add(1)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(1)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Black or Whiteheads",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(2) ? _skin.remove(2) : _skin.add(2)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(2)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Pori Pori Besar",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(3) ? _skin.remove(3) : _skin.add(3)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(3)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Sagging",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(4) ? _skin.remove(4) : _skin.add(4)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(4)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dark Undereyes",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(5) ? _skin.remove(5) : _skin.add(5)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(5)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dullness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(6) ? _skin.remove(6) : _skin.add(6)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(6)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Acne",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(7) ? _skin.remove(7) : _skin.add(7)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(7)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Wrinkles",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(8) ? _skin.remove(8) : _skin.add(8)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(8)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dehydrated",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(9) ? _skin.remove(9) : _skin.add(9)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(9)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Rougness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _skin.contains(10) ? _skin.remove(10) : _skin.add(10)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _skin.contains(10)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Sensitivity",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            // body concern
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "Body Concern",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.7)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text("kamu bisa pilih salah satu"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(0) ? _body.remove(0) : _body.add(0)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(0)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Loose Skin",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(1) ? _body.remove(1) : _body.add(1)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(1)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Unwanted Hair",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(2) ? _body.remove(2) : _body.add(2)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(2)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Uneven Skin Tone",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.23,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(3) ? _body.remove(3) : _body.add(3)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(3)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Body Acne",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.27,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(4) ? _body.remove(4) : _body.add(4)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(4)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Stretch Mark",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(5) ? _body.remove(5) : _body.add(5)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(5)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dullnes",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(6) ? _body.remove(6) : _body.add(6)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(6)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Sensitivity",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(7) ? _body.remove(7) : _body.add(7)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(7)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dryness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.19,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(8) ? _body.remove(8) : _body.add(8)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(8)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Cellulite",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(9) ? _body.remove(9) : _body.add(9)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(9)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Hyperpgementation",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _body.contains(10) ? _body.remove(10) : _body.add(10)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _body.contains(10)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Roughness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            // hair concern
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "Hair Concern",
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.7)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text("kamu bisa pilih salah satu"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(0) ? _hair.remove(0) : _hair.add(0)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(0)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dandruff",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(1) ? _hair.remove(1) : _hair.add(1)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(1)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Sensitive Scalp",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(2) ? _hair.remove(2) : _hair.add(2)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(2)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Split Ends",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.23,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(3) ? _hair.remove(3) : _hair.add(3)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(3)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Flatness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.27,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(4) ? _hair.remove(4) : _hair.add(4)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(4)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Damaged",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(5) ? _hair.remove(5) : _hair.add(5)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(5)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Frizz",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(6) ? _hair.remove(6) : _hair.add(6)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(6)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Grey Hair",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(7) ? _hair.remove(7) : _hair.add(7)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(7)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Dryness",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(8) ? _hair.remove(8) : _hair.add(8)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(8)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Hair Loss",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: HexColor('#203b8d'),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => setState(() =>
                        _hair.contains(9) ? _hair.remove(9) : _hair.add(9)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: _hair.contains(9)
                                  ? HexColor('#203b8d')
                                  : Colors.transparent,
                              width: 5),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(105, 170, 175, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white),
                      child: Center(
                          child: Text(
                        "Oily Scalp",
                        style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      )),
                      // Image.asset('assets/images/female.png'),
                    ),
                  ),
                ),
              ],
            ),
            // Button
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  child: Text(
                    "Selanjutnya",
                    style: TextStyle(color: HexColor('#e6f8f6')),
                  ),
                  onPressed: () {
                    postQuestion();
                  },
                  color: Color.fromRGBO(0, 0, 104, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
