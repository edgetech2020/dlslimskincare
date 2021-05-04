import 'package:dlslim/Pages/history.dart';
import 'package:dlslim/Pages/home_page.dart';
import 'package:dlslim/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'appBar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> keyScaffold = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    History(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Appbar.getAppBar(context),
      key: keyScaffold,
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: Container(
        color: Color.fromRGBO(230, 248, 246, 1),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Hexcolor('#203b8d'),
        onTap: _onItemTapped,
      ),
    );
  }
}
