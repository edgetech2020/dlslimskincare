import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AllTreatment extends StatefulWidget {
  @override
  _AllTreatmentState createState() => _AllTreatmentState();
}

class _AllTreatmentState extends State<AllTreatment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Treat.getList().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Appbar.getAppBar(context),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            width: width * 0.9,
            child: SafeArea(
              top: true,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: height * 0.1,
                      // ),
                      Container(
                        child: Text(
                          'Treatment for face whitening',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list1(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Treatment for scar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list2(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Treatment for face lifting',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list3(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Treatment for body whitening',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list4(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Hair loss treatment',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list5(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Treatment for body slimming',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list6(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Treatment for body slimming',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      list7(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container list1() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: (tre.length > 0 && tre != null)
              ? tre['treatment-for-face-whitening'].length
              : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  // height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          shrinkWrap: true,
                          data: tre['treatment-for-face-whitening'][index]
                              .toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list2() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.9,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: (tre.length > 0) ? tre['treatment-for-scar'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['treatment-for-scar'][index].toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list3() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.9,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:
              (tre.length > 0) ? tre['treatment-for-face-lifting'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['treatment-for-face-lifting'][index]
                              .toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list4() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.8,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:
              (tre.length > 0) ? tre['treatment-for-body-whitening'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['treatment-for-body-whitening'][index]
                              .toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list5() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.8,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: (tre.length > 0) ? tre['hair-loss-treatment'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['hair-loss-treatment'][index].toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list6() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.8,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:
              (tre.length > 0) ? tre['treatment-for-body-slimming'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['treatment-for-body-slimming'][index]
                              .toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container list7() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: height * 0.8,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: (tre.length > 0) ? tre['new-treatment'].length : 1,
          itemBuilder: (context, index) {
            if (tre.length > 0) {
              return Card(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          data: tre['new-treatment'][index].toString(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
