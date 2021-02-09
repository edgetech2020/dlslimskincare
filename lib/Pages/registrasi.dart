import 'dart:convert';
import 'package:dlslim/Pages/gender.dart';
import 'package:dlslim/api/globals.dart' as globals;
import 'package:get/route_manager.dart';
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
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController konfirm = TextEditingController();
  var email = TextEditingController();

  bool isRegistButtonDisabled = false;
  Map<String, dynamic> mseg;
  String msg;
  bool isLogin = false;

  // void emailVal() {
  //   var email = TextEditingController().text;
  //   assert(EmailValidator.validate(email));
  // }

  Future postShared() async {
    setState(() {
      globals.isLoginButtonDisabled = true;
    });
    var body = json.encode({
      'username': username.text,
      'password': password.text,
      'email': email.text
    });
    var url = "http://dlslimskincare.com/wp-json/wp/v2/users/register";
    http.post(url, body: body, headers: {
      "Content-Type": "application/json"
    }).then((http.Response response) async {
      mseg = json.decode(response.body);
      // final int statusCode = mseg["code"];
      if (response.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('isLogin', true);
        pref.setString('response', response.body);
        pref.setString('uname', username.text);
        globals.userId = response.body.toString();
        setState(() {
          isRegistButtonDisabled = true;
        });
        debugPrint(response.body);
        Get.offAll(GenderSex());
      } else
        setState(() {
          msg = mseg["message"] ?? "Anda tidak terhubung ke internet";
          isRegistButtonDisabled = false;
        });
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    var isRegistButton = Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      child: RaisedButton(
        child: (isRegistButtonDisabled == false)
            ? Text(
                "Daftar",
                style: TextStyle(color: Hexcolor('#e6f8f6')),
              )
            : Center(child: CircularProgressIndicator()),
        onPressed: isRegistButtonDisabled
            ? null
            : () {
                setState(() {
                  isRegistButtonDisabled = true;
                });
                // postShared();

                Navigator.pushReplacementNamed(context, '/gender');
              },
        color: Hexcolor('#4C8CA7'),
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
                    image: AssetImage('assets/images/Background Sign Up1.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _form,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  controller: username,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.people),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Hexcolor('#4C8CA7')),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Hexcolor('#4C8CA7')),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    labelText: 'Username',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Username Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Form(
                                  autovalidateMode: AutovalidateMode.always,
                                  child: TextFormField(
                                    validator: validateEmail,
                                    controller: email,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(Icons.mail_outline),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Hexcolor('#4C8CA7')),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Hexcolor('#4C8CA7')),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      labelText: 'E - Mail',
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Hexcolor('#4C8CA7')),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Hexcolor('#4C8CA7')),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        labelText: 'Password',
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'password Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: TextFormField(
                                      controller: konfirm,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Hexcolor('#4C8CA7')),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Hexcolor('#4C8CA7')),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        labelText: 'Konfirmasi Password',
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Required";
                                        }
                                        if (val != password.text) {
                                          return 'Password doesn\'t match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
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
                                        image: AssetImage(
                                            'assets/images/google.png'),
                                        fit: BoxFit.cover,
                                      ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isRegistButton,
                    SizedBox(height: 50, child: Center(child: Text(msg ?? "")))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
