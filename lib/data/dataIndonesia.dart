import 'package:flutter/material.dart';

// ignore: camel_case_types
class dataIndonesia extends StatelessWidget {
  final Map indonesiaData;

  const dataIndonesia({Key key, this.indonesiaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: indonesiaData['cases'].toString(),
          ),
          StatusPanel(
            title: 'POSITIF',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: indonesiaData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: indonesiaData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: indonesiaData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(6)
      ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            count,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins'),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
