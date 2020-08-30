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
        title: Text("COBOT", style: TextStyle(color: Colors.white , fontFamily: 'Poppins')),

      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    'Death Cases',
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               Container(
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     border: Border.all(color: Colors.blueAccent),
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: countryData == null
                     ? CircularProgressIndicator()
                     : MostAffectedPanel(
                   countryData: countryData,
                 ),
               ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'World Information',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
                worldData == null
                    ? CircularProgressIndicator()
                    : WorldwidePanel(
                  worldData: worldData,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Cases By Country',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                  ),
                ),


              ],
            )),
      ),

    );
  }
}
