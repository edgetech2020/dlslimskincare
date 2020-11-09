import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class BeautyId extends StatefulWidget {
  @override
  _BeautyIdState createState() => _BeautyIdState();
}

class _BeautyIdState extends State<BeautyId> {
  int _tipe = 0;
  int _warna = 0;
  int _dasar = 0;
  int _rambut = 0;
  int _warnaRambut = 0;
  int _hijab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/utama.png"),
                        fit: BoxFit.cover)),
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Center(
                      child: Text(
                        'Tipe Kulitmu Seperti Apa ?',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200.0,
                      child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Hexcolor('#203b8d'),
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _tipe = 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: _tipe == 0
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
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2)),
                                      )),
                                      // Image.asset('assets/images/female.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _tipe = 1),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _tipe == 1
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
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _tipe = 2),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _tipe == 2
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
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _tipe = 3),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _tipe == 3
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
                                          "Kombinasi",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Center(
                      child: Text(
                        'Warna Kulitmu ? ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200.0,
                      child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Hexcolor('#203b8d'),
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _warna = 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: _warna == 0
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
                                        "Hitam",
                                        style: TextStyle(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2)),
                                      )),
                                      // Image.asset('assets/images/female.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _warna = 1),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _warna == 1
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
                                          "Coklat",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _warna = 3),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _warna == 3
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
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _warna = 4),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _warna == 4
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
                                          "Putih Kecoklatan",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _warna = 5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _warna == 5
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
                                          "Putih",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Center(
                      child: Text(
                        'Warna Kulit Dasarmu ?  ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200.0,
                      child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Hexcolor('#203b8d'),
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _dasar = 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: _dasar == 0
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
                                        "Warm",
                                        style: TextStyle(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2)),
                                      )),
                                      // Image.asset('assets/images/female.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _dasar = 1),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _dasar == 1
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
                                          "Neutral",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _dasar = 2),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _dasar == 2
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
                                          "Cool",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Center(
                      child: Text(
                        'Tipe Rambut Kamu ?  ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200.0,
                      child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Hexcolor('#203b8d'),
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _rambut = 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: _rambut == 0
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
                                        "Keriting",
                                        style: TextStyle(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2)),
                                      )),
                                      // Image.asset('assets/images/female.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _rambut = 1),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _rambut == 1
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
                                          "Lurus",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Hexcolor('#203b8d'),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _rambut = 2),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _rambut == 2
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
                                          "Bergelombang",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ))
                                        // Image.asset(
                                        //   'assets/images/Pria_perbaikan.png',
                                        // ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Center(
                      child: Text(
                        'Rambutmu Di Warnai ?  ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    // center rambut
                    Center(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                        color: Hexcolor('#203b8d'),
                                        shape: BoxShape.circle),
                                    child: GestureDetector(
                                      onTap: () =>
                                          setState(() => _warnaRambut = 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _warnaRambut == 0
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
                                          "Iya",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        )),
                                        // Image.asset('assets/images/female.png'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.02)),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Hexcolor('#203b8d'),
                                    ),
                                    child: GestureDetector(
                                      onTap: () =>
                                          setState(() => _warnaRambut = 1),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: _warnaRambut == 1
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
                                            "Tidak",
                                            style: TextStyle(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2)),
                                          ))
                                          // Image.asset(
                                          //   'assets/images/Pria_perbaikan.png',
                                          // ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Anda seorang hijaber ?  ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    //center hijab
                    Center(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                        color: Hexcolor('#203b8d'),
                                        shape: BoxShape.circle),
                                    child: GestureDetector(
                                      onTap: () => setState(() => _hijab = 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _hijab == 0
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
                                          "Iya",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        )),
                                        // Image.asset('assets/images/female.png'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.02)),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Hexcolor('#203b8d'),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => setState(() => _hijab = 1),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: _hijab == 1
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
                                            "Tidak",
                                            style: TextStyle(
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2)),
                                          ))
                                          // Image.asset(
                                          //   'assets/images/Pria_perbaikan.png',
                                          // ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RaisedButton(
                          child: Text(
                            "Selanjutnya",
                            style: TextStyle(color: Hexcolor('#e6f8f6')),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/concern');
                          },
                          color: Color.fromRGBO(0, 0, 104, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 0.1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
