import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dlslim/Model/model_profile.dart';
import 'package:dlslim/Pages/camera_update.dart';
import 'package:dlslim/Pages/profile_update.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart' as globals;

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
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
  static const chars = '0a1b2c3e4d5f6g7h8i9jklmnopqrstuvwxy';
  Random rnd = Random();
  String nameFile;
  bool loaded = false;
  File rotatedImage;
  ModelProfile modelProfile = ModelProfile();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      if (loaded != true) {
        loadingAction();
      }
      setState(() {
        ProfileGet.getProf(userId: idUser['user_id'].toString()).then((value) {
          setState(() {
            modelProfile = value;
            loaded = true;
            if (loaded == true) {
              Navigator.pop(context);
            }
          });
        });
      });
    });
  }

  openDialogD(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            height: height * 0.5,
            width: width * 0.9,
            child: PhotoView(
              customSize: Size.fromWidth(width * 0.9),
              imageProvider: NetworkImage(modelProfile.potoDepan),
            ),
          ),
        );
      },
    );
  }

  openDialogl(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            height: height * 0.5,
            width: width * 0.9,
            child: PhotoView(
              customSize: Size.fromWidth(width * 0.9),
              imageProvider: NetworkImage(modelProfile.potoKiri),
            ),
          ),
        );
      },
    );
  }

  openDialogR(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            height: height * 0.5,
            width: width * 0.9,
            child: PhotoView(
              customSize: Size.fromWidth(width * 0.9),
              imageProvider: NetworkImage(modelProfile.potoKanan),
            ),
          ),
        );
      },
    );
  }

  openDialogA(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            color: Colors.transparent,
            height: height * 0.4,
            width: width * 0.9,
            child: PhotoView(
              imageProvider: (imgFile != null)
                  ? MemoryImage(imgFile.readAsBytesSync())
                  : (modelProfile != null)
                      ? NetworkImage(modelProfile.avatar)
                      : NetworkImage(globals.imagenot),
            ),
          ),
        );
      },
    );
  }

  loadingAction() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future getPictCamera(BuildContext context) async {
    final cameraPict = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 720,
        preferredCameraDevice: CameraDevice.front);
    nameFile = getRandomString(5);
    if (cameraPict != null) {
      imgFile = await FlutterExifRotation.rotateImage(path: cameraPict.path);
    }
    setState(() {});

    if (cameraPict != null) {
      pict = await imgFile.readAsBytes();
      UpdateAvatar.upload(idUser['user_id'].toString(), pict, nameFile);
    }
    setState(() {});
    // Get.to(BottomNavBar());
    Navigator.of(context).pop();
  }

  Future getPictGaleri(BuildContext context) async {
    final galleryPict = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    );
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
        child: SafeArea(
          top: true,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  openDialogA(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.37),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                          image: (imgFile != null)
                              ? MemoryImage(imgFile.readAsBytesSync())
                              : (modelProfile.avatar != null)
                                  ? NetworkImage(modelProfile.avatar)
                                  : NetworkImage(globals.imagenot),
                          fit: BoxFit.contain)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: globals.width * 0.55, top: globals.height * 0.1),
                child: InkWell(
                  onTap: () {
                    dialogAva();
                  },
                  child: Icon(
                    Icons.camera_enhance,
                    size: 40,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.16,
                    top: ResponsiveFlutter.of(context).hp(15)),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQueryData.fromWindow(window).size.height *
                              0.01),
                      child: Text(
                        (modelProfile.fullname != null)
                            ? modelProfile.fullname
                            : '-',
                        style: ExtraStyle.profileUname(
                            colors: Color(0xff4C8CA7),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(top: 10),
                      child: Text(
                          (modelProfile.gender != null)
                              ? modelProfile.gender
                              : '-',
                          style: ExtraStyle.profileUname()),
                    ),
                    Container(
                      child: Text(
                        (modelProfile.email != null) ? modelProfile.email : '-',
                        style: ExtraStyle.profileUname(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: ResponsiveFlutter.of(context).hp(22)),
                child: Center(child: container()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container container() {
    return Container(
      width: globals.width * 0.85,
      height: globals.height * 0.58,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ResponsiveFlutter.of(context).hp(1.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 28),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Beauty Concern',
                  style: GoogleFonts.roboto(
                      color: Color(0xff4C8CA7),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(UpdateProfile());
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // alignment: Alignment.centerLeft,
                    child: Text(
                      'Skin Type',
                      style: GoogleFonts.roboto(
                        color: Color(0xff4C8CA7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text((modelProfile.skinType != null)
                          ? modelProfile.skinType
                          : '-')),
                ],
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 28),
                    // alignment: Alignment.centerLeft,
                    child: Text(
                      'Skin Problem',
                      style: GoogleFonts.roboto(
                        color: Color(0xff4C8CA7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text((modelProfile.skinProb != null)
                          ? modelProfile.skinProb
                          : '-')),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 28,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Masalah Kulit Lainnya',
                  style: GoogleFonts.roboto(
                    color: Color(0xff4C8CA7),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, left: 28),
                  child: Text((modelProfile.otherSkinProb != null)
                      ? modelProfile.otherSkinProb
                      : '-')),
              Container(
                margin: EdgeInsets.only(left: 28, top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Sebelumnya',
                  style: GoogleFonts.roboto(
                    color: Color(0xff4C8CA7),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, left: 28, bottom: 10),
                  child: Text((modelProfile.oldProd != null)
                      ? modelProfile.oldProd
                      : '-')),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 28),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Face Review',
                  style: GoogleFonts.roboto(
                      color: Color(0xff4C8CA7),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(CameraUpdate());
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Left',
                      style: GoogleFonts.roboto(
                        color: Color(0xff4C8CA7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openDialogl(context);
                    },
                    child: Container(
                      width: globals.width * 0.15,
                      height: globals.height * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: (modelProfile.potoKiri != null)
                                  ? NetworkImage(modelProfile.potoKiri)
                                  : NetworkImage(globals.imagenot))),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Front',
                      style: GoogleFonts.roboto(
                        color: Color(0xff4C8CA7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openDialogD(context);
                    },
                    child: Container(
                      width: globals.width * 0.15,
                      height: globals.height * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: (modelProfile.potoDepan != null)
                                  ? NetworkImage(modelProfile.potoDepan)
                                  : NetworkImage(globals.imagenot))),
                      // child: ClipRRect(
                      //   child: PhotoView(
                      //     imageProvider: (potoDepan != null)
                      //         ? NetworkImage(potoDepan)
                      //         : NetworkImage(globals.imagenot),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Right',
                      style: GoogleFonts.roboto(
                        color: Color(0xff4C8CA7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openDialogR(context);
                    },
                    child: Container(
                      width: globals.width * 0.15,
                      height: globals.height * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: (modelProfile.potoKanan != null)
                                  ? NetworkImage(modelProfile.potoKanan)
                                  : NetworkImage(globals.imagenot))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
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
                color: Color(0xff4C8CA7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
