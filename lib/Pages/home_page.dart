import 'package:carousel_slider/carousel_slider.dart';
import 'package:dlslim/Pages/detail.dart';
import 'package:dlslim/Pages/test.dart';

import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = List();
  List gambar = [
    'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'
  ];
  List news = List();
  Map beauty = Map();

  double _rating = 0;
  void rate(_string) {
    //Other actions based on rating such as api calls.
    setState(() {});
  }

  //api product
  Future fetchData() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/products/");
    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      list = json.decode(response.body) as List;
      return list;
    } else {
      throw Exception('failed to load json');
    }
  }

  // api gambar
  Future connectAPI() async {
    final respon =
        await http.get("https://dashboard.dlslimskincare.com/api/banners");

    if (respon.statusCode == 200) {
      gambar = json.decode(respon.body) as List;
      return gambar;
    } else {
      throw Exception('failed to load json');
    }
  }

  //api newspromo
  Future newsPromo() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/news");

    if (response.statusCode == 200) {
      news = json.decode(response.body) as List;
      return news;
    } else {
      throw Exception('failed to load json');
    }
  }

  Future beautyTreatment() async {
    final response =
        await http.get("https://dashboard.dlslimskincare.com/api/treatments");

    if (response.statusCode == 200) {
      beauty = json.decode(response.body) as Map;
      return beauty;
    } else {
      throw Exception('failed to load json');
    }
  }

  // GetApi getApi;
  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      setState(() {});
      connectAPI().then((_) {
        setState(() {});
      });
      newsPromo().then((_) {
        setState(() {});
      });
      beautyTreatment().then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.cover)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              FutureBuilder(
                  future: connectAPI(),
                  builder: (context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else
                      return CarouselSlider.builder(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.27,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount: gambar.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Image.network(
                                (gambar[index] != null)
                                    ? gambar[index]
                                    : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png',
                                fit: BoxFit.fill,
                              ));
                  }),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "News & Promo",
                          style: ExtraStyle.styleHeading(),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/news');
                          },
                          child: Text(
                            'Lihat Semua',
                            style: ExtraStyle.styleMore(),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: newsPromo(),
                        builder: (context, s) {
                          if (s.connectionState == ConnectionState.waiting &&
                              !s.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: news.length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        Card(
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55,
                                              decoration: BoxDecoration(
                                                  // color: Color.fromRGBO(32, 59, 141, 1),
                                                  image: DecorationImage(
                                                    image: NetworkImage((news[
                                                                index] !=
                                                            null)
                                                        ? news[index]['image']
                                                        : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  splashColor: Colors.grey,
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            40, 40, 40, 0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                        child: Text(
                                                            news[index]['title']
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: ExtraStyle
                                                                .styleIsi())),
                                                  ),
                                                ),
                                              )),
                                        )));
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product",
                          style: ExtraStyle.styleHeading(),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/product');
                          },
                          child: Text(
                            'Lihat Semua',
                            style: ExtraStyle.styleMore(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FutureBuilder(
                            future: fetchData(),
                            builder: (context, s) {
                              if (s.connectionState ==
                                      ConnectionState.waiting &&
                                  !s.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (list.length > 0 ? 5 : 0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      _rating = double.parse(
                                          list[index]['average_rating'] ?? "");
                                      return Card(
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                                child: new InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, '/detail',
                                                        arguments: ScreenArguments(
                                                            list[index]['id']
                                                                .toString(),
                                                            list[index]['name']
                                                                .toString(),
                                                            list[index]
                                                                    ['images']
                                                                [0]['src'],
                                                            list[index]['price']
                                                                .toString(),
                                                            double.parse(list[index]
                                                                [
                                                                'average_rating']),
                                                            list[index]
                                                                    ['description']
                                                                .toString()));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                        // color: Colors.red,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              230, 248, 246, 1),
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15)),
                                                        ),
                                                        child: OverflowBox(
                                                          // minHeight: 1,
                                                          child: Image.network(
                                                            (list.length > 0)
                                                                ? list[index][
                                                                        'images']
                                                                    [0]['src']
                                                                : 'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png',
                                                            fit: BoxFit.fill,
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: loadingProgress
                                                                              .expectedTotalBytes !=
                                                                          null
                                                                      ? loadingProgress
                                                                              .cumulativeBytesLoaded /
                                                                          loadingProgress
                                                                              .expectedTotalBytes
                                                                      : null,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.03),
                                                        child: Text(
                                                            (list.length > 0)
                                                                ? list[index]
                                                                        ['name']
                                                                    .toString()
                                                                : "loading Data",
                                                            style: ExtraStyle
                                                                .styleProduct()),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Text(
                                                          (list.length > 0)
                                                              ? NumberFormat.currency(
                                                                      locale:
                                                                          'id',
                                                                      symbol:
                                                                          'Rp. ',
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(int.parse(
                                                                      list[index]
                                                                          [
                                                                          'price']))
                                                              : "Loading Data",
                                                          style: ExtraStyle
                                                              .styleProduct(),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: (_rating >=
                                                                    1)
                                                                ? Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        59,
                                                                        141,
                                                                        1)
                                                                : Colors.grey,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: (_rating >=
                                                                    2)
                                                                ? Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        59,
                                                                        141,
                                                                        1)
                                                                : Colors.grey,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: (_rating >=
                                                                    3)
                                                                ? Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        59,
                                                                        141,
                                                                        1)
                                                                : Colors.grey,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: (_rating >=
                                                                    4)
                                                                ? Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        59,
                                                                        141,
                                                                        1)
                                                                : Colors.grey,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: (_rating >=
                                                                    5)
                                                                ? Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        59,
                                                                        141,
                                                                        1)
                                                                : Colors.grey,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ));
                                    });
                            })),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Beauty Treatment",
                          style: ExtraStyle.styleHeading(),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Test()));
                          },
                          child: Text(
                            'Lihat Semua',
                            style: ExtraStyle.styleMore(),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: beautyTreatment(),
                        builder: (context, s) {
                          if (s.connectionState == ConnectionState.waiting &&
                              !s.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        beauty['treatment-for-face-whitening']
                                            .length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        Card(
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              decoration: BoxDecoration(
                                                  // color: Color.fromRGBO(32, 59, 141, 1),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  splashColor: Color.fromRGBO(
                                                      32, 59, 141, 1),
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            40, 40, 40, 0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                        child: Text(
                                                            beauty['treatment-for-face-whitening']
                                                                        [index]
                                                                    ['ID']
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: ExtraStyle
                                                                .styleIsi())),
                                                  ),
                                                ),
                                              )),
                                        )));
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
