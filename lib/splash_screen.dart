import 'dart:async';

import 'package:flutter/material.dart';
import 'Navbar.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }

}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration= Duration(seconds: 3);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Halamannav()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              width: 280,
              height: 280,
              child: Image.asset("images/logoapp.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            Text(
              "Covid-19 ChatBot",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}