import 'package:dlslim/Model/argument.dart';
import 'package:flutter/material.dart';

class BuyNow extends StatefulWidget {
  final BuyNowArg arg;
  BuyNow(this.arg);
  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Belanja"),
      ),
      body: Container(
        child: Center(
          child: Text(widget.arg.id.toString()),
        ),
      ),
    );
  }
}
