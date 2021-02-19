import 'dart:ui';
import 'package:dlslim/api/globals.dart' as globals;
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginPost loginPost;
  Map uid = Map();
  TextEditingController usernm = TextEditingController();
  TextEditingController passrr = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _passwordVisible = false;

  String name = '';

  Map<String, dynamic> mseg;
  String msg = '';
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    var loginRaisedButton = RaisedButton(
      child: Text(
        "Login",
        style: TextStyle(color: Hexcolor('#e6f8f6')),
      ),
      onPressed: globals.isLoginButtonDisabled
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
                globals.gagalMsk = '';
                globals.isLoginButtonDisabled = true;
              });
              LoginPost.loginPostTest(context, usernm.text, passrr.text)
                  .then((_) async {
                if (globals.gagalLogin['success'] == false) {
                  setState(() {
                    globals.isLoginButtonDisabled = false;
                  });
                } else {
                  setState(() {
                    globals.isLoginButtonDisabled = false;
                  });
                }
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('user', usernm.text);
                pref.setString('pass', passrr.text);
              });
              // _login();
            },
      color: Hexcolor('#4C8CA7'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background Login1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                // Container(
                //     child: Image.asset(
                //   'assets/images/logo.png',
                //   fit: BoxFit.cover,
                // )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: usernm,
                    enabled: !globals.isLoginButtonDisabled,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Hexcolor('#4C8CA7')),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Hexcolor('#4C8CA7')),
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
                    enabled: !globals.isLoginButtonDisabled,
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
                        borderSide: BorderSide(color: Hexcolor('#4C8CA7')),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Hexcolor('#4C8CA7')),
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
                    globals.gagalMsk,
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
