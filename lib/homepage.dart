import 'dart:convert';
import 'package:chatbot/data/updateHarian.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'data/dataIndonesia.dart';
import 'package:http/http.dart' as http;
import 'hospitalmodel.dart';
import 'userviewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as sliderPopup;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Map worldData;
  Map indonesiaData;
  Map updateData;
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

  fetchUpdateData() async {
    http.Response response =
    await http.get('https://data.covid19.go.id/public/api/update.json');
    setState(() {
      updateData = json.decode(response.body);
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
    fetchUpdateData();
    print('fetchData called');
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
      print(kota);
      setState(() {
        _currentAddress =
        "${place.subAdministrativeArea}, ${place.administrativeArea} (${place.country})";
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


  _openURL(){
    var url='https://www.google.com/search?q=rumah+sakit+rujukan+covid+terdekat&oq=rumah+sakit+rujukan+covid+terdekat&aqs=chrome..69i57.11003j1j4&sourceid=chrome&ie=UTF-8';
    launch(url);
  }

  _gmapsURL(text){
    print(text);
    var url= 'https://www.google.co.id/maps/place/'+text;
    launch(url);
  }

  String formatted;

  _currentDate(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd('en_US');
    formatted = formatter.format(now);
  }

  void _showSimpleDialog(String address, String number, String name) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        backgroundColor: Colors.blue[400],
        contentPadding: EdgeInsets.only(bottom: 30, top:20, right: 10,left: 10),
        children: <Widget>[
          Center(
            child: Container(
              alignment: Alignment.topLeft,
              width: 130,
              height: 130,
              child: Image.asset("images/hospital.png"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 220,
              child: Center(
                  child: Text(
                    name,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              _gmapsURL(address);
            },
            child: Center(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        width: 26,
                        height: 26,
                        child: Image.asset("images/maplogo.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Google Maps',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              launch("tel://"+number);
            },
            child: Center(
              child: (number==null)? Container():Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        width: 20,
                        height: 20,
                        child: Image.asset("images/phone.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Call Number',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    );
  }

  void _showDialog(String address, String number) {
    sliderPopup.showSlideDialog(
      context: context,
      pillColor: Colors.white,
      backgroundColor: Colors.blue,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _gmapsURL(address);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Google Maps',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              launch("tel://"+number);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Call Number',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _getCurrentLocation();
    _currentDate();
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
        title: Text("HOME", style: TextStyle(color: Colors.white , fontFamily: 'Poppins')),

      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20, right: 10, left: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Update Covid-19 Indonesia',
                          style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                      Center(
                        child: (updateData==null)? Text('No Update Data',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ): Text('Recently Update at '+ updateData['update']['penambahan']['tanggal'],
                          style: TextStyle(fontSize: 13, color: Colors.white,fontWeight: FontWeight.bold),
                        ),),
                      SizedBox(
                        height: 10,
                      ),
                      updateData == null
                          ? CircularProgressIndicator()
                          : updateHarian(
                        updateData: updateData,
                      ),

                    ],
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
                        'Data Indonesia ',
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: indonesiaData == null
                      ? CircularProgressIndicator()
                      : dataIndonesia(
                    indonesiaData: indonesiaData,
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
                      Center(
                        child: Text(
                          'Nearest Covid-19 Hospital',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          width: 20,
                          height: 20,
                          child: Image.asset("images/maplogo.png"),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        (_currentAddress==null )? Text('Cannot load current position', style: TextStyle(fontWeight: FontWeight.bold),): Text(_currentAddress,style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),


                dataUser == null ?  CircularProgressIndicator(): ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dataUser.length,
                  itemBuilder: (context, i) {
                    return _regex(dataUser[i].region.toLowerCase())==true ? Card(
                      color: (i%2)==0 ?Colors.green[300]: Colors.blue[300],
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new ListTile(
                            title: new Text(dataUser[i].name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                            subtitle: new Text(dataUser[i].address+"\n"+(dataUser[i].phone??'No Phone Data') , style: TextStyle(fontSize: 12, color: Colors.white),),
                            onTap: (){
//                            _gmapsURL(dataUser[i].address);
//                            _showDialog(dataUser[i].address,dataUser[i].phone);
                              _showSimpleDialog(dataUser[i].address,dataUser[i].phone,dataUser[i].name);
                            },
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
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _openURL();
                    },
                    child: Center(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                width: 26,
                                height: 26,
                                child: Image.asset("images/googlelogo.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'MORE INFO',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

