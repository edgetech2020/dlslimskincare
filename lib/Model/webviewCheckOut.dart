import 'dart:convert';

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadUP.getUP().then((value) {
      debugPrint('get id');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut'),
      ),
      body: Container(
        child: InAppWebView(
          initialUrl: 'https://dlslimskincare.com/checkout',
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
            clearCache: true,
            cacheEnabled: false,
          )),
          initialHeaders: {
            'DL_MOBILE': 'IOS',
            "Authorization":
                "Basic " + base64Encode(utf8.encode('$username:$password'))
          },
        ),
      ),
    );
  }
}
