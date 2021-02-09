import 'package:dlslim/Model/appBar.dart';
import 'package:dlslim/api/globals.dart' as glob;
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/testget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Whislist extends StatefulWidget {
  @override
  _WhislistState createState() => _WhislistState();
}

class _WhislistState extends State<Whislist> {
  Map whis;

  void initState() {
    super.initState();
    ShareAll.getUserID().then((_) {
      setState(() {
        GetWhislist.getWhistlist().then((value) {
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppBar(context),
      body: Container(
        width: glob.width * 1,
        height: glob.height * 1,
        child: Container(
          child: FutureBuilder(
              future: GetWhislist.getWhistlist(),
              builder: (BuildContext context, s) {
                if (s.connectionState == ConnectionState.waiting &&
                    !s.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if ((glob.whislistGet != null) &&
                    glob.whislistGet.length > 0) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: (glob.whislistGet['data'].isNotEmpty)
                          ? glob.whislistGet['data'].length
                          : 0,
                      itemBuilder: (BuildContext context, index) {
                        // debugPrint(whis.toString());
                        return Card(
                          child: Row(
                            children: [
                              Container(
                                width: glob.width * 0.3,
                                height: glob.height * 0.1,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://dlslimskincare.com/wp-content/uploads/2020/10/no-image-icon-6.png'))),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((glob.whislistGet['data'].isNotEmpty)
                                      ? glob.whislistGet['data'][index]['name']
                                          .toString()
                                      : 'data tidak ditemukan'),
                                  Text((glob.whislistGet['data'].isNotEmpty)
                                      ? NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(int.parse(
                                              glob.whislistGet['data'][index]
                                                  ['price']))
                                      : 'tidak ada harga')
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return Container(
                    child: Center(child: Text('tidak ada whislist')),
                  );
                }
              }),
        ),
      ),
    );
  }
}
