import 'dart:convert';

import 'dart:io';

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CameraUpdate extends StatefulWidget {
  @override
  _CameraUpdateState createState() => _CameraUpdateState();
}

class _CameraUpdateState extends State<CameraUpdate> {
  File tampakDepan;
  File tampakKanan;
  File tampakKiri;
  String tampakDepanBase64;
  String tampakKananBase64;
  String tampakKiriBase64;
  String hslTampakDepan;
  String status = '';
  String base64Image;
  File tmpFile;
  final picker = ImagePicker();
  String errMessage = 'Error Uploading Image';
  String msg = '';
  String tampakDepanSize;
  bool isButtonoff = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // LoadUP.getUidRes().then((value) {
    //   setState(() {
    //     debugPrint(userRegist.toString());
    //   });
    // });
    ShareAll.getUserID().then((value) {
      setState(() {});
    });
  }

  Future frontCamera() async {
    final front = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 640,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      if (front != null) {
        tampakDepan = File(front.path);
      }
    });
    if (front != null) {
      tampakDepanBase64 = base64Encode(tampakDepan.readAsBytesSync());
      var size = await tampakDepan.readAsBytes();
      tampakDepanSize = size.length.toString();
    }
  }

  Future rightCamera() async {
    final right = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 640,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      if (right != null) {
        tampakKanan = File(right.path);
      }
    });
    if (right != null) {
      tampakKananBase64 = base64Encode(tampakKanan.readAsBytesSync());
    }
  }

  Future leftCamera() async {
    final left = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 640,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      if (left != null) {
        tampakKiri = File(left.path);
      }
    });
    if (left != null) {
      tampakKiriBase64 = base64Encode(tampakKiri.readAsBytesSync());
    }
  }

  void savePict() async {
    await SharedPreferences.getInstance().then((gg) {
      gg.setString('depan', tampakDepanBase64);
      gg.setString('kanan', tampakKananBase64);
      gg.setString('kiri', tampakKiriBase64);
    });
  }

  Future loadPict() async {
    SharedPreferences pict = await SharedPreferences.getInstance();
    setState(() {
      hslTampakDepan = pict.getString('result');
    });
  }

  @override
  Widget build(BuildContext context) {
    var raisedButton = RaisedButton(
      elevation: 5.0,
      child: new Text(
        "Update Foto",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 0.5,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arial Black',
        ),
      ),
      color: Hexcolor('#4C8CA7'),
      onPressed: isButtonoff
          ? null
          : () {
              Photo.updateFoto(
                  idUser['user_id'].toString(),
                  tampakDepanBase64 ?? '',
                  tampakKananBase64 ?? '',
                  tampakKiriBase64);
              // savePict();
            },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
    return Scaffold(
        extendBody: true,
        key: _scaffoldKey,
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage(
                          //             'assets/images/Background-Login 1.jpg'),
                          //         fit: BoxFit.cover)),
                          )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.4)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  // padding: const EdgeInsets.symmetric(horizontal: 100),
                                  child: Column(
                                    children: <Widget>[
                                      // Text(
                                      //   'Supaya kami dapat mengetahui masalah pada keluhan kulit anda',
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize:
                                      //         ResponsiveFlutter.of(context)
                                      //             .fontSize(2.5),
                                      //   ),
                                      //   textAlign: TextAlign.center,
                                      // ),

                                      Text(
                                        'silahkan melakukan foto',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 250,
                                        height: 50,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          child: new Text(
                                            "Tampak Depan",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Arial Black',
                                            ),
                                          ),
                                          color:
                                              Color.fromRGBO(208, 249, 255, 1),
                                          onPressed: () {
                                            frontCamera();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                        )),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: (tampakDepan != null)
                                          ? Colors.green[400]
                                          : Colors.grey[300],
                                      size: 30,
                                    )
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 30)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 250,
                                        height: 50,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          child: new Text(
                                            "Tampak Kanan",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Arial Black',
                                            ),
                                          ),
                                          color:
                                              Color.fromRGBO(208, 249, 255, 1),
                                          onPressed: () {
                                            rightCamera();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                        )),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: (tampakKanan != null)
                                          ? Colors.green[400]
                                          : Colors.grey[300],
                                      size: 30,
                                    )
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 30)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 250,
                                        height: 50,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          child: new Text(
                                            "Tampak Kiri",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Arial Black',
                                            ),
                                          ),
                                          color:
                                              Color.fromRGBO(208, 249, 255, 1),
                                          onPressed: () {
                                            leftCamera();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                        )),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: (tampakKiri != null)
                                          ? Colors.green[400]
                                          : Colors.grey[300],
                                      size: 30,
                                    )
                                  ],
                                ),
                                // Text(tampakDepanSize ?? 'null'),
                                Padding(
                                    padding: const EdgeInsets.only(top: 60)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 50,
                                    child: raisedButton),
                                Padding(padding: const EdgeInsets.only(top: 5)),
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: FlatButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        'Skip For Now',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}