import 'dart:ui';

import 'package:dlslim/Model/m_beautyTreatment.dart';
import 'package:dlslim/Model/m_carousel.dart';
import 'package:dlslim/Model/m_newsPromo.dart';
import 'package:dlslim/Model/m_product.dart';
import 'package:dlslim/Pages/test.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:dlslim/Pages/api/api_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsApi> newsApi = List();
  List<NewsNew> news = List();

  @override
  // ignore: override_on_non_overriding_member
  void initstate() {
    super.initState();
    NewsApi.connectAPI().then((_) {
      setState(() {});
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
              ApiCarousel.apiCarousel(),
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
                    ApiNewsPromo.apiNewsPromo(),
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
                    ApiProduct.apiProduct(),
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
                    ApiBeautyTreatment.apiBeautyTreatment(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    // Container(
                    //   height:
                    //       MediaQueryData.fromWindow(window).size.height * 0.4,
                    //   width: MediaQueryData.fromWindow(window).size.width * 0.9,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: FutureBuilder(builder: (context, s) {
                    //     if (s.connectionState == ConnectionState.waiting &&
                    //         s.hasData) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     } else
                    //       return ListView.builder(
                    //           itemCount: newsApi.length,
                    //           itemBuilder: (context, index) {
                    //             return Card(
                    //                 child:
                    //                     Text(newsApi[index].title.toString()));
                    //           });
                    //   }),
                    // )
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
