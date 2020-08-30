import 'package:flutter/material.dart';
import 'hospitalmodel.dart';
import 'userviewmodel.dart';

class HalamanUtama extends StatefulWidget {
//  String namaKota= 'Tarakan';
//  String namaProv= 'Jawa Timur';
//  String gabungan= 'Kota '+namaKota;
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  List<Hospitalmodel> dataUser = new List();
  void getDataUser() {
    HospitalViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Utama"),
      ),
      body: dataUser == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemCount: dataUser.length,
        itemBuilder: (context, i) {

          return (dataUser[i].province).toLowerCase() == 'kalimantan timur'? Card(
//            color: (i%2)==0 ?Colors.blue[100]: Colors.white,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ExpansionTile(
                    title: new Text(dataUser[i].name),
                    children: <Widget>[
                      new ListTile(
                        title: new Text(dataUser[i].address),
                        subtitle: new Text(dataUser[i].phone??'No Phone Data'),
                      )
                    ]
                ),
              ],
            ),
          ): Container();
        },
      ),
    );

  }
}