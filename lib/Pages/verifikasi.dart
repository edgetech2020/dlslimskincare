import 'dart:async';

import 'package:dlslim/Model/model_verif.dart';
import 'package:dlslim/Pages/login.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:dlslim/api/api_controller.dart';

class Verifikasi extends StatefulWidget {
  final String email;
  final String method;
  Verifikasi({this.email, this.method});
  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
  int time = 60;
  Timer timer;
  bool isLoading = false;
  ModelVerif mdl = ModelVerif();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  countdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        setState(() {
          timer.cancel();
          time = 60;
          isLoading = false;
        });
      } else if (timer.isActive) {
        setState(() {
          time--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C8CA7),
        title: Text('Verifikasi'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.85,
                child: Text(
                  'Email verifikasi telah dikirim ke ${widget.email} harap periksa email masuk atau spam, dan lakukan login kembali',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // RaisedButton(onPressed: () {

              // }),
              Container(
                width: width * 0.85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF4C8CA7)),
                    onPressed: isLoading
                        ? null
                        : () {
                            countdown();
                            VerifyEmail.verifySent(email: widget.email)
                                .then((value) {
                              setState(() {
                                mdl = value;
                                debugPrint('Regist : ' + mdl.ok.toString());
                                Fluttertoast.showToast(msg: mdl.pesan);
                              });
                            });
                            if (time != 0) {
                              isLoading = true;
                              setState(() {});
                            } else {
                              isLoading = false;
                              setState(() {});
                            }
                          },
                    child: (time == 60)
                        ? Text('Kirim ulang email')
                        : Text(time.toString())),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.off(Login());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: width * 0.85,
                  child: Text('Sign In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
