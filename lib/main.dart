import 'package:dlslim/Pages/beauty_concern.dart';
import 'package:dlslim/Pages/beauty_id.dart';
import 'package:dlslim/Pages/camera.dart';
import 'package:dlslim/Pages/gender.dart';

import 'package:dlslim/Pages/home_page.dart';
import 'package:dlslim/Pages/registrasi.dart';
import 'package:flutter/material.dart';

import 'Pages/cartList.dart';
import 'Pages/detail.dart';
import 'Pages/detailNews.dart';
import 'Pages/hal_login.dart';
import 'Pages/login.dart';
import 'Model/bottomnavbar.dart';
import 'Pages/newPromo.dart';
import 'Pages/product.dart';
import 'Pages/skin.dart';
import 'Pages/splas.dart';
import 'Pages/camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // darkTheme: ThemeData.dark(),
      title: 'DL Slim Skin Care',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => Login(),
        '/hal': (BuildContext ctxt) => Hal(),
        '/registrasi': (BuildContext context) => Registrasi(),
        '/gender': (BuildContext context) => GenderSex(),
        '/skin': (BuildContext context) => SkinPage(),
        '/camera': (BuildContext context) => CameraFace(),
        '/beauty': (BuildContext context) => BeautyId(),
        '/concern': (BuildContext context) => Concern(),
        '/home': (BuildContext context) => HomePage(),
        '/rumah': (BuildContext context) => BottomNavBar(),
        '/news': (BuildContext context) => NewsPromo(),
        '/product': (BuildContext context) => Product(),
        '/detail': (context) =>
            DetailPage(ModalRoute.of(context).settings.arguments),
        '/detailnews': (context) =>
            DetailNews(ModalRoute.of(context).settings.arguments),
        '/cartlist': (BuildContext context) => CartList(),
      },
    );
  }
}
