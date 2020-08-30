import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'data/dataIndonesia.dart';
import 'package:http/http.dart' as http;
import 'hospitalmodel.dart';
import 'userviewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Map worldData;
  Map indonesiaData;
  Position _currentPosition;
  String _currentAddress;
  String kota='null';

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Hospitalmodel> dataUser = new List();

  void getDataUser() {
    HospitalViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  void _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      kota= place.subAdministrativeArea;

      setState(() {
        _currentAddress =
        "${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _regex(String region){
    String compare= kota.toLowerCase();
    var kotasplit= compare.split(' ');
    var regionSplit = region.split(',');
    String regionA= regionSplit[0].replaceAll('kota ', '');
    var compareRegion = regionA.split(' ');

      for(var j=0; j<kotasplit.length; j++){
        if(compareRegion[compareRegion.length-1] == kotasplit[j]){
          return true;
        }
      }
    }

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
    _getCurrentLocation();
    fetchData();
    getDataUser();
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
            padding: EdgeInsets.only(bottom: 20, right: 10, left: 10, top: 20),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 20,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Rumah sakit Covid-19 terdekat',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (_currentAddress==null )? Text('No Connection'): Text(_currentAddress),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),


            dataUser == null ?  CircularProgressIndicator(): ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataUser.length,
              itemBuilder: (context, i) {
                return _regex(dataUser[i].region.toLowerCase())==true ? Card(
            color: (i%2)==0 ?Colors.green[200]: Colors.blue[200],
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                          title: new Text(dataUser[i].name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                          subtitle: new Text(dataUser[i].address+"\n"+(dataUser[i].phone??'No Phone Data') , style: TextStyle(fontSize: 12, color: Colors.white),),
//                          children: <Widget>[
//                            new ListTile(
//                              title: new Text(dataUser[i].address, style: TextStyle(fontSize: 12),),
//                              subtitle: new Text(dataUser[i].phone??'No Phone Data'),
//                            )
//                          ]
                      ),
                    ],
                  ),
                ): Container();
              },
            ),

          ],
        )
        ),
      ),
    );
  }
}
