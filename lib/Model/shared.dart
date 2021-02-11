import 'dart:convert';

import 'package:dlslim/Pages/hal_login.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dlslim/api/globals.dart' as globals;

class ShareAll {
  static Future getUserID() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      globals.idUser = json.decode(pref.getString('response'));
      // Future
    } catch (e) {}
  }
}

class LoadUP {
  static Future getUP() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    globals.username = pref.getString('username');
    globals.password = pref.getString('password');
  }

  static Future getUidRes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    globals.userRegist = json.decode(pref.getString('regist'));
  }

  static Future loadAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    gender = pref.getInt('gender');
  }
}

class Logout {
  static Future logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref?.clear();
    // Get.off(Hal());
    Get.offAll(Hal());
  }
}
