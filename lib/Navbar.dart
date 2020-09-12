import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'second.dart';
import 'top.dart';

void main() {
  runApp(new MaterialApp(
    title: "My Apps",
    home: new Halamannav(),
  ));
}

class Halamannav extends StatefulWidget {
  @override
  _HalamannavState createState() => _HalamannavState();
}

class _HalamannavState extends State {
  int _selectedIndex = 0;

  final _widgetOptions = [
    Second(),
    MyHomePage(),
    Top()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
bottomNavigationBar: CurvedNavigationBar(
  height: 60,
  color: Colors.blue,
  backgroundColor: Colors.white,
  items: <Widget>[
    Icon(Icons.home, color: Colors.white,),
    Icon(Icons.chat, color: Colors.white,),
    Icon(Icons.flag, color: Colors.white,),
  ],
          onTap: _onItemTapped,
),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}