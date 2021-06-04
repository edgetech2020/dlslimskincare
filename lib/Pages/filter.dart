import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/Pages/product.dart';
import 'package:dlslim/api/api_controller.dart';
import 'package:dlslim/api/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: Center(
          child: Container(
        margin: EdgeInsets.only(top: 30),
        width: width * 0.9,
        child: FutureBuilder(
          future: FilterSearch.filterSearch().then((value) {
            debugPrint(jsonFilter.toString());
            debugPrint(jsonFilter.toString());
            setState(() {});
          }),
          builder: (ctx, s) {
            if (s.connectionState == ConnectionState.waiting && !s.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: (jsonFilter != null) ? jsonFilter.length : 1,
                itemBuilder: (context, index) {
                  if (jsonFilter != null) {
                    return InkWell(
                      onTap: () {
                        print(jsonFilter[index]['id']);
                        Get.to(Product(
                          id: jsonFilter[index]['id'],
                        ));
                      },
                      child: Container(
                        // margin: EdgeInsets.only(top: 2),
                        width: width * 0.6,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.03,
                              height: width * 0.03,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4C8CA7)),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  jsonFilter[index]['name'],
                                  style: TextStyle(
                                      color: Color(0xFF4C8CA7), fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          },
        ),
      )),
    );
  }
}
