import 'package:dlslim/api/globals.dart';
import 'package:dlslim/Model/history_model.dart';
import 'package:dlslim/Model/shared.dart';
import 'package:dlslim/api/testget.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  TabController tabController;

  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
    ShareAll.getUserID().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(top: height * 0.03),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
            ),
            TabBar(
                controller: tabController,
                labelColor: Colors.blue,
                isScrollable: true,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700),
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                tabs: <Widget>[
                  Text('Semua'),
                  Text('Proses'),
                  Text('Menunggu'),
                  Text('Selesai'),
                  Text('Batal')
                ]),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                //Semua
                FutureBuilder(
                  future: HistoryGet.getHistory(),
                  builder: (BuildContext context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return MHistory.historiAll();
                  },
                ),
                FutureBuilder(
                  future: HistoryGet.getHistoryP(),
                  builder: (BuildContext context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return MHistory.historiProses();
                  },
                ),
                FutureBuilder(
                  future: HistoryGet.getHistoryM(),
                  builder: (BuildContext context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return MHistory.historiMenunggu();
                  },
                ),
                FutureBuilder(
                  future: HistoryGet.getHistoryS(),
                  builder: (BuildContext context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return MHistory.historiSelesai();
                  },
                ),
                FutureBuilder(
                  future: HistoryGet.getHistory(),
                  builder: (BuildContext context, s) {
                    if (s.connectionState == ConnectionState.waiting &&
                        !s.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return MHistory.historiBatal();
                  },
                ),

                // Text('test'),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
