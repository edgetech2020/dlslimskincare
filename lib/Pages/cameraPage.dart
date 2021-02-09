import 'dart:io';

import 'package:dlslim/Model/openCamera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.1),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.grey[200],
              child: (imageFile != null) ? Image.file(imageFile) : SizedBox(),
            ),
            RaisedButton(
              onPressed: () async {
                imageFile = await Navigator.push<File>(
                    context, MaterialPageRoute(builder: (_) => OpenCamera()));
                setState(() {});
              },
              child: Text('Open Camera'),
            )
          ],
        ),
      ),
    );
  }
}
