import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map idUser = Map();
  Map uid = Map();

  void initstate() {
    super.initState();
    idApi();
  }

  Future idApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = json.decode(pref.getString('response')) as Map;
    final response = await http.get(
        'https://dashboard.dlslimskincare.com/api/user-detail/' +
            idUser['user_id'].toString());
    if (response.statusCode == 200) {
      uid = json.decode(response.body) as Map;
    }
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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            FutureBuilder(
                future: idApi(),
                builder: (context, s) {
                  if (s.connectionState == ConnectionState.waiting &&
                      !s.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage("https:" + uid['avatar'] ??
                                  'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                              fit: BoxFit.contain)),
                      child: Text(uid['user_login'].toString() ?? 'Noname'),
                    );
                }),
            Container(
              width: 250.0,
              child: RaisedButton(
                child: Text(
                  "LogOut",
                  style: TextStyle(color: Color.fromRGBO(230, 248, 246, 1)),
                ),
                onPressed: () {
                  logoutUser();
                },
                color: Color.fromRGBO(0, 0, 104, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
