import 'dart:convert';
import 'package:dlslim/Model/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registrasi extends StatefulWidget {
  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  String msg = "";
  bool isRegistButtonDisabled = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future postShared() async {
    var body = json.encode({
      'username': username.text,
      'password': password.text,
      'email': email.text
    });
    var url = "";
    http.post(url, body: body, headers: {
      "Content-Type": "application/json"
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('response', response.body);
        globals.userId = response.body;
        Navigator.pushReplacementNamed(context, '/gender');
      } else
        return setState(() {
          msg = "Gagal daftar periksa koneksi internet anda";
          isRegistButtonDisabled = false;
        });
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isRegistButton = Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      width: MediaQuery.of(context).size.width * 0.9,
      child: RaisedButton(
        child: Text(
          "Daftar",
          style: TextStyle(color: Hexcolor('#e6f8f6')),
        ),
        onPressed: isRegistButtonDisabled
            ? null
            : () {
                FocusScope.of(context).unfocus();
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Row(
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Text("  proses....")
                    ],
                  ),
                ));
                setState(() {
                  msg = '';
                  isRegistButtonDisabled = true;
                });
                postShared();
              },
        color: Color.fromRGBO(0, 0, 104, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/utama.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Daftar Disini',
                  style: ExtraStyle.styleHeading(),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(32, 59, 141, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(32, 59, 141, 1)),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(32, 59, 141, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(32, 59, 141, 1)),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.mail_outline),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(32, 59, 141, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(32, 59, 141, 1)),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'E - Mail',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.01,
                      color: Colors.black,
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(32, 59, 141, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.transparent,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {},
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/facebook.png'),
                                    fit: BoxFit.values[2],
                                  ))),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(32, 59, 141, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Material(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {},
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/google.png'),
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                      ],
                    ),
                  ],
                ),
                isRegistButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
