import 'package:dlslim/Pages/webview_treatment.dart';
import 'package:dlslim/style/extraStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBeautyTreatment {
  static Container apiBeautyTreatment() {
    List beauty = List();

    Future beautyTreatment() async {
      final response =
          await http.get("https://dashboard.dlslimskincare.com/api/treatments");

      if (response.statusCode == 200) {
        beauty = json.decode(response.body) as List;
        print(beauty);
        return beauty;
      }
    }

    logicButton(String value) async {
      switch (value) {
        case 'New Treatment':
          Get.to(WebviewTreatment(
            id: '#id-1',
          ));
          break;
        case 'Treatment For Face Whitening':
          Get.to(WebviewTreatment(
            id: '#id-3',
          ));
          break;
        case 'Treatment For Scar':
          Get.to(WebviewTreatment(
            id: '#id-4',
          ));
          break;
        case 'Treatment For Scar':
          Get.to(WebviewTreatment(
            id: '#id-5',
          ));
          break;
        case 'Treatment For Body Whitening':
          Get.to(WebviewTreatment(
            id: '#id-6',
          ));
          break;
        case 'Hair Loss Treatment':
          Get.to(WebviewTreatment(
            id: '#id-7',
          ));
          break;
        case 'Treatment For Body Slimming':
          Get.to(WebviewTreatment(
            id: '#id-8',
          ));
          break;
        default:
      }
    }

    return Container(
      child: FutureBuilder(
          future: beautyTreatment(),
          builder: (context, s) {
            if (s.connectionState == ConnectionState.waiting && !s.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: beauty.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                    // color: Color.fromRGBO(32, 59, 141, 1),
                                    image: DecorationImage(
                                      image: NetworkImage(beauty[index]['data']
                                              ['image'] ??
                                          'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () async {
                                      print(beauty[index]['name']);
                                      // Get.to(WebviewTreatment(
                                      //   id: '#id-7',
                                      // ));
                                      logicButton(beauty[index]['name']);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(40, 40, 40, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                          child: Text(
                                              beauty[index]['name'].toString(),
                                              textAlign: TextAlign.center,
                                              style: ExtraStyle.styleIsi())),
                                    ),
                                  ),
                                )),
                          )));
          }),
    );
  }
}
