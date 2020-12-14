import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkinPage extends StatefulWidget {
  @override
  _SkinPageState createState() => _SkinPageState();
}

class _SkinPageState extends State<SkinPage> {
  int _value = 0;

  Future saveBeautyID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('tipeKulitWajah', _value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 10,
        height: MediaQuery.of(context).size.height * 10,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/utama.png"), fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 10,
                    child: Center(
                        child: Text(
                      "Bisa anda beritahu kami bagaimana kondisi kulit wajah kamu",
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      ),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width * 0.37,
                              decoration: BoxDecoration(
                                  color: Hexcolor('#203b8d'),
                                  shape: BoxShape.circle),
                              child: GestureDetector(
                                onTap: () => setState(() => _value = 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: _value == 0
                                              ? Hexcolor('#203b8d')
                                              : Colors.transparent,
                                          width: 5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                105, 170, 175, 0.3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ],
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                    "Berminyak",
                                    style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(3)),
                                  )),
                                  // Image.asset('assets/images/female.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width * 0.37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Hexcolor('#203b8d'),
                              ),
                              child: GestureDetector(
                                onTap: () => setState(() => _value = 1),
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: _value == 1
                                                ? Hexcolor('#203b8d')
                                                : Colors.transparent,
                                            width: 5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  105, 170, 175, 0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ],
                                        color: Colors.white),
                                    child: Center(
                                        child: Text(
                                      "Normal",
                                      style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(3)),
                                    ))
                                    // Image.asset(
                                    //   'assets/images/Pria_perbaikan.png',
                                    // ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05),
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.width * 0.37,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Hexcolor('#203b8d'),
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() => _value = 2),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: _value == 2
                                            ? Hexcolor('#203b8d')
                                            : Colors.transparent,
                                        width: 5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              105, 170, 175, 0.3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ],
                                    color: Colors.white),
                                child: Center(
                                    child: Text(
                                  "Kering",
                                  style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(3)),
                                )),
                                // Image.asset('assets/images/male.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      child: Text(
                        "Selanjutnya",
                        style: TextStyle(color: Hexcolor('#e6f8f6')),
                      ),
                      onPressed: () {
                        saveBeautyID();
                        Navigator.pushNamed(context, '/beauty');
                      },
                      color: Color.fromRGBO(0, 0, 104, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
