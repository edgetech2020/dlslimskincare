import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernm = TextEditingController();
  TextEditingController passrr = new TextEditingController();

  String name = '';

  String msg = '';
  bool isLogin = false;

  void login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', true);
    if (isLogin == true) {
      pref.setString('username', usernm.text);
    }
  }

  // void loginSave() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('username', usernm.text);

  //   setState(() {
  //     name = usernm.text;
  //     isLogin = true;
  //   });
  //   usernm.clear();
  // }

  Future _login() async {
    var body = json.encode({'username': usernm.text, 'password': passrr.text});
    var url = "https://dlslimskincare.com/wp-json/remote-login/login";
    http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        setState(() {
          msg = 'Login berhasil';
        });
        Navigator.pushReplacementNamed(context, '/rumah');
      } else
        return setState(() {
          msg = 'username/password salah silahkan coba lagi ya bunds';
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/utama.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                    child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: usernm,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Hexcolor('#203b8d')),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Hexcolor('#203b8d')),
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: passrr,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Hexcolor('#203b8d')),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Hexcolor('#203b8d')),
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: 250.0,
                  child: RaisedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Hexcolor('#e6f8f6')),
                    ),
                    onPressed: () {
                      _login();
                      login();
                    },
                    color: Color.fromRGBO(0, 0, 104, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  child: Text(
                    msg,
                    style: ExtraStyle.productTitle(),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
