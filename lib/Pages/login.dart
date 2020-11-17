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
  Map uid = Map();
  TextEditingController usernm = TextEditingController();
  TextEditingController passrr = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _passwordVisible = false;

  String name = '';

  String msg = '';
  bool isLogin = false;
  bool isLoginButtonDisabled = false;

  Future _login() async {
    var body = json.encode({'username': usernm.text, 'password': passrr.text});
    var url = "https://dlslimskincare.com/wp-json/remote-login/login";
    http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    ).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('isLogin', true);
        pref.setString('username', usernm.text);
        pref.setString('response', response.body);
        Navigator.pushReplacementNamed(context, '/rumah');
      } else
        return setState(() {
          msg = 'username/password salah silahkan coba lagi ya bunds';
          isLoginButtonDisabled = false;
        });
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginRaisedButton = RaisedButton(
      child: Text(
        "Login",
        style: TextStyle(color: Hexcolor('#e6f8f6')),
      ),
      onPressed: isLoginButtonDisabled
          ? null
          : () {
              FocusScope.of(context).unfocus();
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                content: new Row(
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("  Sedang Masuk...")
                  ],
                ),
              ));
              setState(() {
                msg = '';
                isLoginButtonDisabled = true;
              });
              _login();
            },
      color: Color.fromRGBO(0, 0, 104, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    return Scaffold(
      key: _scaffoldKey,
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
                    enabled: !isLoginButtonDisabled,
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
                    enabled: !isLoginButtonDisabled,
                    obscureText: !_passwordVisible,
                    onSubmitted: (_) {
                      loginRaisedButton.onPressed?.call();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
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
                  child: loginRaisedButton,
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
