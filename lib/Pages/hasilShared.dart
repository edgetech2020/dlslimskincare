import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Hasil extends StatefulWidget {
  @override
  _HasilState createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  TextEditingController controller = TextEditingController();
  String name = " ";
  bool isLogin = true;
  Map uid = Map();
  Map idUser = Map();
  String userEmail;

  Future loadLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('username') ?? " gagal load";
    setState(() {});
  }

  Future loadIslogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool('isLogin') ?? false;
    setState(() {});
  }

  Future loadId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = json.decode(pref.getString('response')) as Map;
  }

  Future idApi(String id) async {
    final response = await http
        .get('https://dashboard.dlslimskincare.com/api/user-detail/' + id);
    if (response.statusCode == 200) {
      uid = json.decode(response.body) as Map;
      setState(() {
        userEmail = uid['user_email'].toString();
      });
    }
  }
  // }
  // Future<void> loadUid(String id) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.getString('response');
  //   final respon = await http
  //       .get("https://dashboard.dlslimskincare.com/api/user-detail/" + id);

  //   if (respon.statusCode == 200) {
  //     uid = json.decode(respon.body) as Map;
  //     // print(product);
  //   } else {
  //     throw Exception('failed to load json');
  //   }
  // }

  // @override
  // // ignore: override_on_non_overriding_member
  // void initstate() {
  //   super.initState();
  //   loadUid('');
  // }

  // void saveUid() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('userEmail', uid['ID'].toString());
  // }

  // Future loadId() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   idUser = pref.getString('userEmail') ?? "gagal";
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text("anda login sebagai $name"),
          RaisedButton(
              child: Text('Load'),
              onPressed: () {
                loadLogin();
                setState(() {});
              }),
          Text(isLogin.toString()),
          RaisedButton(
              child: Text('Load'),
              onPressed: () {
                loadIslogin();
                setState(() {});
              }),
          Text(userEmail.toString() ?? ""),
          RaisedButton(
              child: Text('Load'),
              onPressed: () {
                loadId().then((_) {
                  idApi(idUser['user_id'].toString());
                  setState(() {});
                });
              })
        ],
      )),
    );
  }
}
