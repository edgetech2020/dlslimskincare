import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int _value = 0;
  List skinType = ['Normal', 'Sensitive', 'Combination', 'Oily'];
  List skinProblem = [
    'Acne (Jerawat)',
    'Melasma(Flek Hitam)',
    'Acne Scars',
    'Dullness(Kusam)'
  ];
  List<Widget> type = [];
  List<Widget> problem = [];
  int i;
  int now = 0;
  int prob = 0;
  var masalahLain = TextEditingController();
  var productSebelum = TextEditingController();

  @override
  void initState() {
    super.initState();
    ShareAll.getUserID().then((value) {
      setState(() {});
    });
    buildWidget();
  }

  void buildWidget() {
    type = [];
    problem = [];
    setState(() {
      for (i = 0; i < skinType.length; i++) {
        type.add(conten(skinType[i], i));
      }
      for (i = 0; i < skinProblem.length; i++) {
        problem.add(problems(skinProblem[i], i));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Container(
            width: width * 0.93,
            child: listBody(context),
          ),
        ),
      ),
    );
  }

  ListView listBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          width: width * 0.8,
          child: Text(
            'Gender',
            style: TextStyle(
                color: Hexcolor('#4C8CA7'),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Hexcolor(
                    '#203b8d',
                  ),
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _value = 1),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: _value == 1
                                ? Hexcolor('#4C8CA7')
                                : Colors.transparent,
                            width: 5),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(105, 170, 175, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ],
                        color: Colors.white),
                    child: Image.asset('assets/images/pria.png'),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Hexcolor('#203b8d'),
              ),
              child: GestureDetector(
                onTap: () => setState(() => _value = 0),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: _value == 0
                              ? Hexcolor('#4C8CA7')
                              : Colors.transparent,
                          width: 5),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(105, 170, 175, 0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ],
                      color: Colors.white),
                  child: Image.asset('assets/images/wanita.png'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Skin Type',
              style: TextStyle(
                  color: Hexcolor('#4C8CA7'),
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Pilih sesuai dengan kondisi wajahmu saat ini',
              style: TextStyle(
                color: Hexcolor('#4C8CA7'),
                fontSize: 15,
              )),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: type,
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Skin Problems',
              style: TextStyle(
                  color: Hexcolor('#4C8CA7'),
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Pilih sesuai dengan kondisi wajahmu saat ini',
              style: TextStyle(
                color: Hexcolor('#4C8CA7'),
                fontSize: 15,
              )),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: problem,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          width: width * 0.8,
          child: tex(
              labelText: 'Permasalahan kulit lainnya', controller: masalahLain),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          width: width * 0.8,
          child: tex(
              labelText: 'Produk yang digunakan sebelumnya',
              controller: productSebelum),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          width: width * 0.8,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              RegistQue.storeQues(
                  userId: idUser['user_id'].toString(),
                  gender: gender.toString(),
                  skinType: now.toString(),
                  skinProblem: prob.toString(),
                  otherSkinProblem: masalahLain.text ?? '',
                  prevProduct: productSebelum.text ?? '');
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            color: Hexcolor('#4C8CA7'),
          ),
        )
      ],
    );
  }

  TextFormField tex({TextEditingController controller, String labelText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Hexcolor('#4C8CA7'), width: 5)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Hexcolor('#4C8CA7'), width: 5)),
          labelText: labelText,
          labelStyle: TextStyle(color: Hexcolor('#4C8CA7'))),
    );
  }

  InkWell conten(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          now = index;
          debugPrint(now.toString());
          buildWidget();
        });
      },
      child: Container(
        width: width * 0.4,
        height: height * 0.05,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 1)
            ],
            border: Border.all(
                color:
                    (now == index) ? Hexcolor('#4C8CA7') : Colors.transparent,
                width: 5),
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(title)),
      ),
    );
  }

  InkWell problems(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          prob = index;
          debugPrint(prob.toString());
          buildWidget();
        });
      },
      child: Container(
        width: width * 0.4,
        height: height * 0.05,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 1)
            ],
            border: Border.all(
                color:
                    (prob == index) ? Hexcolor('#4C8CA7') : Colors.transparent,
                width: 5),
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(title)),
      ),
    );
  }
}
