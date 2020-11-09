import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CameraFace extends StatefulWidget {
  @override
  _CameraFaceState createState() => _CameraFaceState();
}

class _CameraFaceState extends State<CameraFace> {
  File imageFile;

  // _openGallery(BuildContext context) async {
  //   var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   this.setState(() {
  //     imageFile = picture;
  //   });
  //   Navigator.of(context).pop();
  // }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _dialogChoice(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose One ?"),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ]),
            ),
          );
        });
  }

  // Widget _logic1(){
  //   if(imageFile == null){
  //     return Text ("Poto nya Gak ada CUK");
  //   } else {
  //     Image.file(imageFile,width: 200, height:200);
  //   }
  // }

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
                            Container(
                                width: 300,
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
                                    _dialogChoice(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                )),
                            Padding(padding: const EdgeInsets.only(top: 30)),
                            Container(
                                width: 300,
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
                                    _dialogChoice(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                )),
                            Padding(padding: const EdgeInsets.only(top: 30)),
                            Container(
                                width: 300,
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
                                    _dialogChoice(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                )),
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
                                    Navigator.pushNamed(context, '/skin');
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
                                    Navigator.pushNamed(context, '/skin');
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
    //   child: imageFile == null
    //       ? Center(
    //           child: FlatButton(
    //           onPressed: () {
    //             _dialogChoice(context);
    //           },
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 child: Icon(Icons.add_a_photo, size: 50,))
    //             ],
    //           ),
    //         ))
    //       : Image.file(imageFile),
    // ),
    //  Container(
    //       width: 250,
    //       child: RaisedButton(
    //         elevation: 5.0,
    //         child: Text(
    //           'Selanjutnya',
    //           style: TextStyle(
    //             color: Colors.white,
    //             letterSpacing: 0.5,
    //             fontSize: 20.0,
    //             fontWeight: FontWeight.bold,
    //             fontFamily: 'Arial Black',
    //           ),
    //         ),
    //         onPressed: () {
    //           Navigator.pushReplacementNamed(context, '/survey');
    //         },
    //         color: Color.fromRGBO(0, 0, 104, 1),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15)),
    //       ),
    //     )
    // RaisedButton(
    //   onPressed: () {
    //     _dialogChoice(context);
    //   },
    //   child: Text("Take a Picture"),
    // )
  }
}
