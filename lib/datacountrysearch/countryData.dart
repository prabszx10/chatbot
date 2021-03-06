
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchCountryData.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("DAFTAR NEGARA", style: TextStyle(color: Colors.white , fontFamily: 'Poppins')),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){
            showSearch(context: context, delegate: Search(countryData));
          },)
        ],

        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: (){
      Navigator.pop(context);
      },
        ),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
        padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Card(
                  color: (index%2)!=0 ?Colors.grey[100]: Colors.blue[100],
                  child: Flexible(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  countryData[index]['country'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Image.network(
                                  countryData[index]['countryInfo']['flag'],
                                  height: 50,
                                  width: 60,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'POSITIF:' +
                                          countryData[index]['active'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      'TERKONFIRMASI:' +
                                          countryData[index]['cases'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      'SEMBUH:' +
                                          countryData[index]['recovered'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      'MENINGGAL:' +
                                          countryData[index]['deaths'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
