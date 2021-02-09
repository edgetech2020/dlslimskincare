import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: field(hintText: 'Nama'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: field(hintText: 'Nama'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: field(hintText: 'Nama'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: field(hintText: 'Nama'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: field(hintText: 'Nama'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField field({TextEditingController controller, String hintText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          hintText: hintText,
          enabledBorder: InputBorder.none,
          border: InputBorder.none),
    );
  }
}
