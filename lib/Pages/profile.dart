import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dlslim/Model/bottomnavbar.dart';
import 'package:dlslim/Pages/camera_update.dart';
import 'package:dlslim/Pages/profile_update.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart' as globals;

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Map idUser = Map();
  Map uid = Map();
  File imgFile;
  List<int> pict;
  String potoDepan;
  String avatar;
  String fullname;
  String email;
  String potoKiri;
  String potoKanan;
  String gender;
  String skinType;
  String skinProb;
  String otherSkinProb;
  String oldProd;
  static const chars = '0a1b2c3e4d5f6g7h8i9jklmnopqrstuvwxy';
  Random rnd = Random();
  String nameFile;

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      setState(() {
        ProfileGet.getProf(userId: idUser['user_id'].toString()).then((value) {
          setState(() {
            try {
              potoKiri =
                  globals.profileGet['datas']['capture_filename']['left'];
              potoDepan =
                  globals.profileGet['datas']['capture_filename']['front'];
              potoKanan =
                  globals.profileGet['datas']['capture_filename']['right'];
            } catch (e) {
              potoKiri = globals.imagenot;
              potoDepan = globals.imagenot;
              potoKanan = globals.imagenot;
            }
            avatar = globals.profileGet['datas']['avatar_url'];
            fullname = globals.profileGet['datas']['username'];
            email = globals.profileGet['datas']['email'];

            gender = globals.profileGet['datas']['_gender'];
            skinType = globals.profileGet['datas']['skin_type'];
            skinProb = globals.profileGet['datas']['skin_problem'];
            otherSkinProb = globals.profileGet['datas']['other_skin_problem'];
            oldProd = globals.profileGet['datas']['prev_product'];
          });
        });
      });
    });
  }

  Future getPictCamera(BuildContext context) async {
    final cameraPict = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 270,
        maxWidth: 360,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      nameFile = getRandomString(5);
      if (cameraPict != null) {
        imgFile = File(cameraPict.path);
      }
    });
    if (cameraPict != null) {
      pict = await imgFile.readAsBytesSync();
      UpdateAvatar.upload(idUser['user_id'].toString(), pict, nameFile);
    }
    setState(() {});
    Get.to(BottomNavBar());
    Navigator.of(context).pop();
  }

  Future getPictGaleri(BuildContext context) async {
    final galleryPict = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxHeight: 270,
        maxWidth: 360,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      nameFile = getRandomString(5);
      if (galleryPict != null) {
        imgFile = File(galleryPict.path);
      }
    });
    if (galleryPict != null) {
      pict = await galleryPict.readAsBytes();
      // await File(galleryPict.path).writeAsBytes(pict);
      // pict = base64Encode(imgFile.readAsBytesSync());
      UpdateAvatar.upload(idUser['user_id'].toString(), pict, nameFile);
    }
    setState(() {});
    Get.to(BottomNavBar());
    Navigator.of(context).pop();
  }

  dialogAva() {
    showDialog(
        context: (context),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih Salah Satu'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        getPictGaleri(context);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        getPictCamera(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref?.clear();
    Navigator.pushReplacementNamed(context, '/hal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          top: true,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.35),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    image: DecorationImage(
                        image: (imgFile != null)
                            ? MemoryImage(imgFile.readAsBytesSync())
                            : (avatar != null)
                                ? NetworkImage(avatar)
                                : NetworkImage(globals.imagenot),
                        fit: BoxFit.contain)),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: globals.width * 0.55, top: globals.height * 0.13),
                child: InkWell(
                  onTap: () {
                    dialogAva();
                  },
                  child: Icon(
                    Icons.settings,
                    size: 50,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.16,
                    top: MediaQuery.of(context).size.width * 0.45),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromRGBO(32, 59, 141, 1),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQueryData.fromWindow(window).size.height *
                              0.04),
                      child: Text(
                        (fullname != null) ? fullname : '-',
                        style: ExtraStyle.profileUname(),
                      ),
                    ),
                    Container(
                      child: Text(
                        (email != null) ? email : '-',
                        style: ExtraStyle.profileUname(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.35),
                child: profileList(),
              )
              // Positioned.fill(
              //     child: DraggableScrollableSheet(
              //         initialChildSize: 0.55,
              //         minChildSize: 0.55,
              //         maxChildSize: 0.8,
              //         builder: (BuildContext context,
              //             ScrollController scrollController) {
              //           return Container(
              //             decoration: BoxDecoration(
              //                 color: Colors.blue[100],
              //                 borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(30),
              //                     topRight: Radius.circular(30))),
              //             child:
              //                 profileList(scrollController: scrollController),
              //           );
              //         })),
            ],
          ),
        ),
      ),
    );
  }

  ListView profileList({ScrollController scrollController}) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(CameraUpdate());
                },
                child: Container(
                  width: globals.width * 0.8,
                  height: globals.height * 0.12,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: globals.width * 0.15,
                            height: globals.height * 0.07,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: (potoKiri != null)
                                        ? NetworkImage(potoKiri)
                                        : NetworkImage(globals.imagenot))),
                          ),
                          Container(
                            width: globals.width * 0.15,
                            height: globals.height * 0.07,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: (potoDepan != null)
                                        ? NetworkImage(potoDepan)
                                        : NetworkImage(globals.imagenot))),
                          ),
                          Container(
                            width: globals.width * 0.15,
                            height: globals.height * 0.07,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: (potoKanan != null)
                                        ? NetworkImage(potoKanan)
                                        : NetworkImage(globals.imagenot))),
                          ),
                        ],
                      ),
                      Text('Ubah Foto Kondisi Wajah')
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(UpdateProfile());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: globals.width * 0.8,
                  height: globals.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: ExtraStyle.profileTextTitle(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text((gender != null) ? gender : '-'),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Skin Type',
                              style: ExtraStyle.profileTextTitle(),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text((skinType != null) ? skinType : '-')),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Skin Problem',
                              style: ExtraStyle.profileTextTitle(),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text((skinProb != null) ? skinProb : '-')),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Masalah Kulit Lainnya',
                              style: ExtraStyle.profileTextTitle(),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                                (otherSkinProb != null) ? otherSkinProb : '-')),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Product Sebelumnya',
                              style: ExtraStyle.profileTextTitle(),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text((oldProd != null) ? oldProd : '-')),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Ubah Profile')),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 250.0,
                  child: RaisedButton(
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Logout.logoutUser(context);
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              SizedBox(
                height: globals.height * 0.1,
              ),
            ],
          );
        });
  }
}
