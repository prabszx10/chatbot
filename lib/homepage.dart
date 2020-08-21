import 'dart:convert';
import 'package:chatbot/second.dart';
import 'package:flutter/material.dart';
import 'datasorce.dart';
import 'pages/countyPage.dart';
import 'panels/indonesiapanel.dart';
import 'panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  Map indonesiaData;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  fetchIndonesiaData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries/360');
    setState(() {
      indonesiaData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
    fetchIndonesiaData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("COBOT", style: TextStyle(color: Colors.white , fontFamily: 'Poppins')),

      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Container(
//              height: 100,
//              alignment: Alignment.center,
//              padding: EdgeInsets.all(10),
//              color: Colors.orange[100],
//              child: Text(
//                DataSource.quote,
//                style: TextStyle(
//                    color: Colors.orange[800],
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Indonesia',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            indonesiaData == null
                ? CircularProgressIndicator()
                : IndonesiaPanel(
              indonesiaData: indonesiaData,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                ],
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Worldwide',
//                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                  ),
//
//                ],
//              ),
//            ),
//            worldData == null
//                ? CircularProgressIndicator()
//                : WorldwidePanel(
//                    worldData: worldData,
//                  ),

//            SizedBox(
//              height: 10,
//            ),
//            countryData == null
//                ? Container()
//                : MostAffectedPanel(
//                    countryData: countryData,
//                  ),
////            InfoPanel(),
//            SizedBox(
//              height: 20,
//            ),
//            Center(
//                child: Text(
//              'WE ARE TOGETHER IN THE FIGHT',
//              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//            )),
//            SizedBox(
//              height: 50,
//            )
          ],
        )),
      ),
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        selectedFontSize: 18,
//        unselectedFontSize: 15,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//            backgroundColor: Colors.blue,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.message),
//            title: Text('Message'),
//            backgroundColor: Colors.blue,
//          ),
//        ],
//        onTap: (index){
//          setState(() {
//            _currentIndex=index;
//          });
//        },
//      ),
    );
  }
}
