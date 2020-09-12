import 'dart:convert';
import 'package:flutter/material.dart';
import 'data/dataDunia.dart';
import 'datacountrysearch/countryData.dart';
import 'data/terdampak.dart';
import 'package:http/http.dart' as http;

class Top extends StatefulWidget {
  @override
  _Top createState() => _Top();
}

class _Top extends State<Top> {
  List countryData;
  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  Future fetchData() async{
    fetchCountryData();
    fetchWorldWideData();
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
        title: Text("GLOBAL INFO", style: TextStyle(color: Colors.white , fontFamily: 'Poppins')),

      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Container(
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     color: Colors.grey[300],
                     borderRadius: BorderRadius.circular(10)
                 ),
                 child: Column(
                     children: <Widget>[
                       Center(
                         child: Text(
                           'Konfirmasi Kasus Terbanyak',
                           style: TextStyle(fontSize: 18, fontFamily: 'Poppins',color: Colors.black), textAlign: TextAlign.center,
                         ),
                       ),
                       SizedBox(
                         height: 5,
                       ),
                         countryData == null
                             ? CircularProgressIndicator()
                             : epicentrumeCases(
                           countryData: countryData,
                         ),


                     ]

                 ),
               ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Data Covid-19 Dunia',
                        style: TextStyle(fontSize: 17, fontFamily: 'Poppins'),
                      ),

                    ],
                  ),
                ),
                worldData == null
                    ? CircularProgressIndicator()
                    : dataDunia(
                  worldData: worldData,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              width: 25,
                              height: 25,
                              child: Image.asset("images/globe.png"),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'TAMPILKAN KASUS REGIONAL',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                  ),
                ),


              ],
            )),
      ),

    );
  }
}
