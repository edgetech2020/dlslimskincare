import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class BeautyId extends StatefulWidget {
  @override
  _BeautyIdState createState() => _BeautyIdState();
}

class _BeautyIdState extends State<BeautyId> {
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        // backgroundColor: Colors.transparent,
        body: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Background Beauty Concern1.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        margin: EdgeInsets.only(left: 25),
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.3,
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
              margin: EdgeInsets.only(right: 20),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: type,
              ),
            ),
            SizedBox(
              height: height * 0.05,
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
              margin: EdgeInsets.only(right: 20),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: problem,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              width: width * 0.8,
              child: tex(
                  labelText: 'Permasalahan kulit lainnya',
                  controller: masalahLain),
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
              height: height * 0.01,
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              width: width * 0.8,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  RegistQue.storeQues(
                      userId: idUser['user_id'].toString(),
                      gender: gender.toString(),
                      conditionFace: faceCondition.toString(),
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
        ),
      ),
    ));
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

  @override
  void initState() {
    super.initState();
    buildWidget();
    LoadUP.loadAPI().then((_) {
      setState(() {
        debugPrint('Gender : ' + gender.toString());
        // debugPrint('Face Condition : ' + faceCondition.toString());
      });
    });
    LoadUP.getUidRes().then((value) {
      setState(() {});
    });
    ShareAll.getUserID().then((value) {
      setState(() {});
    });
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
        child: Center(
            child: Text(
          title,
          style: GoogleFonts.roboto(color: Hexcolor('#4C8CA7')),
        )),
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
