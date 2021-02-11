import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCarousel {
  static Container apiCarousel() {
    print("triggered carousel");
    List gambar = [
      'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'
    ];
    Future carouselApi() async {
      final respon =
          await http.get("https://dashboard.dlslimskincare.com/api/banners");

      if (respon.statusCode == 200) {
        gambar = json.decode(respon.body) as List;
        return gambar;
      }
    }

    return Container(
      child: FutureBuilder(
          future: carouselApi(),
          builder: (context, s) {
            if (s.connectionState == ConnectionState.waiting && !s.hasData) {
              return Center(child: CircularProgressIndicator());
            } else
              return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.15,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
    );
  }
}
