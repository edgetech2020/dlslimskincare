import 'package:dlslim/Model/argument.dart';
import 'package:dlslim/style/extraStyle.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuyNow extends StatefulWidget {
  final BuyNowArg arg;
  BuyNow(this.arg);
  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  int qty = 1;
  int price;
  int total;
  int jneYesHarga = 20000;
  int jneOkeHarga = 15000;
  int jneRegHarga = 10000;

  int jne;

  void initState() {
    super.initState();
    price = widget.arg.harga;
    jne = jneYesHarga;
    total = price + jne;
    setState(() {});
  }

  void quantityAdd() {
    setState(() {
      qty++;
      price = widget.arg.harga * qty;
      // total = price + pengiriman;
      total = price + jne;
    });
  }

  void quantityRemove() {
    setState(() {
      if (qty <= 1) {
        qty = 1;
      } else {
        qty--;
      }
      price = widget.arg.harga * qty;
      total = price + jne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Belanja"),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 248, 246, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03),
                          height: MediaQuery.of(context).size.height * 0.2,
                          // width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                          ),
                          child: Image(
                            image: NetworkImage((widget.arg.foto != null)
                                ? widget.arg.foto
                                : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              widget.arg.name,
                              style: ExtraStyle.productBuyNow(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(
                                      int.parse(widget.arg.harga.toString())),
                              style: ExtraStyle.productBuyNow(),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(Icons.remove),
                              iconSize: 30.0,
                              color: Color.fromRGBO(32, 59, 141, 1),
                              onPressed: () {
                                setState(() {
                                  quantityRemove();
                                });
                              }),
                          Text(
                            '$qty',
                            style: TextStyle(fontSize: 25),
                          ),
                          IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 30.0,
                              color: Color.fromRGBO(32, 59, 141, 1),
                              onPressed: () {
                                setState(() {
                                  quantityAdd();
                                });
                              }),
                        ],
                      ),
                    ),
                  ]),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengiriman',
                      style: ExtraStyle.styleHeading(),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(230, 248, 246, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Text('Masukan Alamat')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(230, 248, 246, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(child: Text('Jenis Pengiriman')),
                                Container(child: Text('Estimasi Pengiriman')),
                                Container(child: Text('Harga')),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey[300],
                              onTap: () {
                                setState(() {
                                  jne = jneYesHarga;
                                  price = widget.arg.harga * qty;
                                  total = price + jne;
                                });
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  jne = jneYesHarga;
                                                  price =
                                                      widget.arg.harga * qty;
                                                  total = price + jne;
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: jne == jneYesHarga
                                                        ? Color.fromRGBO(
                                                            32, 59, 141, 1)
                                                        : Colors.transparent),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('JNE YES')
                                      ],
                                    ),
                                    Container(child: Text('1     Hari')),
                                    Container(
                                        child: Text(jneYesHarga.toString())),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey[300],
                              onTap: () {
                                setState(() {
                                  jne = jneOkeHarga;
                                  price = widget.arg.harga * qty;
                                  total = price + jne;
                                });
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  jne = jneOkeHarga;
                                                  price =
                                                      widget.arg.harga * qty;
                                                  total = price + jne;
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: jne == jneOkeHarga
                                                        ? Color.fromRGBO(
                                                            32, 59, 141, 1)
                                                        : Colors.transparent),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('JNE Oke')
                                      ],
                                    ),
                                    Container(child: Text('2 - 4 Hari')),
                                    Container(
                                        child: Text(jneOkeHarga.toString())),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey[300],
                              onTap: () {
                                setState(() {
                                  jne = jneRegHarga;
                                  price = widget.arg.harga * qty;
                                  total = price + jne;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  jne = jneRegHarga;
                                                  price =
                                                      widget.arg.harga * qty;
                                                  total = price + jne;
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: jne == jneRegHarga
                                                        ? Color.fromRGBO(
                                                            32, 59, 141, 1)
                                                        : Colors.transparent),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('JNE Reg')
                                      ],
                                    ),
                                    Container(child: Text('3 - 4 Hari')),
                                    Container(
                                        child: Text(jneRegHarga.toString())),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Center(child: Text("$total")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ));
  }
}
