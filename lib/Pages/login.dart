import 'dart:convert';
import 'dart:ui';
import 'package:dlslim/Model/bottomnavbar.dart';
import 'package:dlslim/Pages/gender.dart';
import 'package:dlslim/Pages/verifikasi.dart';
import 'package:dlslim/api/globals.dart' as globals;
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginPost loginPost = LoginPost();
  Map uid = Map();
  TextEditingController usernm = TextEditingController();
  TextEditingController passrr = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _passwordVisible = false;

  String name = '';

  Map<String, dynamic> mseg;
  String msg = '';
  bool isLogin = false;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final facebookLogin = FacebookLogin();
      final facebookLoginResult = await facebookLogin.logIn(['email']);

      print(facebookLoginResult.accessToken);
      print(facebookLoginResult.accessToken.token);
      print(facebookLoginResult.accessToken.expires);
      print(facebookLoginResult.accessToken.permissions);
      print(facebookLoginResult.accessToken.userId);
      print(facebookLoginResult.accessToken.isValid());

      print(facebookLoginResult.errorMessage);
      print(facebookLoginResult.status);

      final token = facebookLoginResult.accessToken.token;

      /// for profile details also use the below code
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
      var profile = json.decode(graphResponse.body);
      print(profile);
      Get.offAll(BottomNavBar());
      SharedPreferences up = await SharedPreferences.getInstance();
      up.setBool('isLogin', true);
      print('Test username : ' + profile['name']);
      up.setString('user', profile['name']);
      print('Test password : ' + passrr.text);

      /*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   */
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var loginRaisedButton = RaisedButton(
      child: Text(
        "Login",
        style: TextStyle(color: Hexcolor('#e6f8f6')),
      ),
      onPressed: globals.isLoginButtonDisabled
          ? null
          : () async {
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
              SharedPreferences up = await SharedPreferences.getInstance();
              up.setBool('isLogin', true);
              print('Test username : ' + usernm.text);
              up.setString('user', usernm.text);
              print('Test password : ' + passrr.text);

              up.setString('pass', passrr.text);
              LoginPost.loginPostTest(context, usernm.text, passrr.text)
                  .then((value) async {
                loginPost = value;

                setState(() {});
                Get.offAll(BottomNavBar());

                // switch (loginPost.response) {
                //   case '000':
                //     Get.offAll(BottomNavBar());

                //     break;
                //   case '001':
                //     Get.to(Verifikasi(
                //       email: usernm.text,
                //     ));
                //     break;
                //   case '002':
                //     Get.to(GenderSex(
                //       uname: usernm.text,
                //     ));
                //     break;
                //   case '003':
                //     Get.to(Verifikasi(
                //       email: usernm.text,
                //     ));
                //     break;
                //   default:
                // }
                // if (globals.gagalLogin['success'] == false) {
                //   setState(() {
                //     globals.isLoginButtonDisabled = false;
                //   });
                // } else {
                //   setState(() {
                //     globals.isLoginButtonDisabled = false;
                //   });
                // }
                // SharedPreferences pref = await SharedPreferences.getInstance();
                // pref.setString('user', usernm.text);
                // pref.setString('pass', passrr.text);
              });
              // _login();
            },
      color: Hexcolor('#4C8CA7'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: true,
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
                  height: 70,
                  child: Text(
                    globals.gagalMsk,
                    style: ExtraStyle.productTitle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              onTap: signInWithFacebook,
                              child: Image(
                                image: AssetImage('assets/images/facebook.png'),
                                fit: BoxFit.values[2],
                              ))),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Container(
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
                              onTap: signInWithGoogle,
                              child: Image(
                                image: AssetImage('assets/images/google.png'),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
