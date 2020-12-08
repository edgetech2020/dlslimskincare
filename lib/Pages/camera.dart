import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CameraFace extends StatefulWidget {
  @override
  _CameraFaceState createState() => _CameraFaceState();
}

class _CameraFaceState extends State<CameraFace> {
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

  Future frontCamera() async {
    final front = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 640,
      maxWidth: 640,
    );
    setState(() {
      if (front != null) {
        tampakDepan = File(front.path);
      }
    });
    tampakDepanBase64 = json.encode(tampakDepan.readAsBytesSync());
  }

  Future rightCamera() async {
    final right = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (right != null) {
        tampakKanan = File(right.path);
      }
    });
    tampakKananBase64 = json.encode(tampakKanan.readAsBytesSync());
    print(tampakDepanBase64);
  }

  Future leftCamera() async {
    final left = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (left != null) {
        tampakKiri = File(left.path);
      }
    });
    tampakKiriBase64 = json.encode(tampakKiri.readAsBytesSync());
  }

  void savePict() async {
    SharedPreferences pict = await SharedPreferences.getInstance();
    pict.setString('depan', tampakDepanBase64);
    pict.setString('kanan', tampakKananBase64);
    pict.setString('kiri', tampakKiriBase64);
  }

  Future loadPict() async {
    SharedPreferences pict = await SharedPreferences.getInstance();
    setState(() {
      hslTampakDepan = pict.getString('result');
    });
  }

  // setStatus(String message) {
  //   setState(() {
  //     status = message;
  //   });
  // }

  // sendPicture() async {
  //   // setStatus('Upload Image');
  //   // if (null == tmpFile) {
  //   //   setStatus(errMessage);
  //   //   return;
  //   // }
  //   // String fileName = tmpFile.path.split('/').last;
  //   if (tampakDepan != null) {
  //     await postPict(tampakDepanBase64).then((value) {
  //       if (value) {
  //       } else {
  //         msg = 'Foto tampak depan gagal upload silahkan upload ulang';
  //       }
  //     }).catchError((error) {
  //       throw ('Exception error');
  //     });
  //   }
  //   if (tampakKanan != null) {
  //     await postPict(tampakKananBase64).then((value) {
  //       if (value) {
  //       } else {
  //         msg = 'Foto tampak kanan gagal upload silahkan upload ulang';
  //       }
  //     }).catchError((error) {
  //       throw ('Exception error');
  //     });
  //   }
  //   if (tampakKiri != null) {}
  // }

  Future postPict() async {
    var url = 'https://dashboard.dlslimskincare.com/api/user-meta';
    // var body = Map<String, dynamic>();
    // body['base64_image'] = tampakDepanBase64.substring(
    //     (tampakDepanBase64.indexOf(",")) + 1, tampakDepanBase64.length);
    http.post(url, body: {}).then((result) async {
      // setStatus(result.statusCode == 200 ? result.body : errMessage);
      if (result.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('result', result.body);
        Map resultt = json.decode(result.body) as Map;
        return setState(() {
          msg = resultt['ok'].toString();
        });
      }
      // return resultt["ok"];
    }).catchError((error) {
      throw (error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/utama.png'),
                        fit: BoxFit.cover)),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.3)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 100),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              // padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Supaya kami dapat mengetahui masalah pada keluhan kulit anda',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07)),
                                  Text(
                                    'silahkan melakukan foto',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 20)),
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
                                      color: Color.fromRGBO(208, 249, 255, 1),
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
                            Padding(padding: const EdgeInsets.only(top: 30)),
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
                                      color: Color.fromRGBO(208, 249, 255, 1),
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
                            Padding(padding: const EdgeInsets.only(top: 30)),
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
                                      color: Color.fromRGBO(208, 249, 255, 1),
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
                            Text(msg ?? 'null'),
                            Text(tampakDepanBase64 ?? 'null'),
                            Padding(padding: const EdgeInsets.only(top: 100)),
                            Container(
                                width: 400,
                                height: 50,
                                child: RaisedButton(
                                  elevation: 5.0,
                                  child: new Text(
                                    "Lanjutkan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial Black',
                                    ),
                                  ),
                                  color: Color.fromRGBO(0, 0, 104, 1),
                                  onPressed: () {
                                    postPict();

                                    // Navigator.pushNamed(context, '/skin');
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                )),
                            Padding(padding: const EdgeInsets.only(top: 5)),
                            Container(
                              width: 300,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    // setState(() {

                                    loadPict();
                                    // });
                                    // Navigator.pushNamed(context, '/skin');
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
    )));
  }
}
