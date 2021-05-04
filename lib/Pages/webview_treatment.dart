import 'dart:convert';

import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewTreatment extends StatefulWidget {
  final String id;
  WebviewTreatment({this.id});
  @override
  _WebviewTreatmentState createState() => _WebviewTreatmentState();
}

class _WebviewTreatmentState extends State<WebviewTreatment> {
  String url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadUP.getUP().then((value) {
      setState(() {});
    });
    url = 'https://dlslimskincare.com/treatment/' + widget.id;
    setState(() {});
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beauty treatment'),
      ),
      body: InAppWebView(
        // initialOptions: InAppWebViewGroupOptions(
        //     crossPlatform: InAppWebViewOptions(
        //   clearCache: true,
        //   cacheEnabled: false,
        // )),
        // initialHeaders: {
        //   'DL_MOBILE': 'IOS',
        //   "Authorization":
        //       "Basic " + base64Encode(utf8.encode('$username:$password'))
        // },
        onLoadStop: (controller, url) async {
          await Future.delayed(Duration(milliseconds: 500));
          String js =
              "jQuery(document).ready(function(){jQuery(\"header,footer,.wrap-breadcrumb,#wpadminbar,#tidio-chat,.page-title.the-title\").remove()},10000);setInterval(function(){jQuery('.blockUI.blockOverlay').remove()})";
          await controller.evaluateJavascript(source: js);
        },
        initialUrl: 'https://dlslimskincare.com/treatment/' + widget.id,
      ),
    );
  }
}
