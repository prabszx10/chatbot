import 'package:flutter/material.dart';

class IndonesiaPanel extends StatelessWidget {
  final Map indonesiaData;

  const IndonesiaPanel({Key key, this.indonesiaData}) : super(key: key);

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
            title: 'Terkonfirmasi',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: indonesiaData['cases'].toString(),
          ),
          StatusPanel(
            title: 'Positif',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: indonesiaData['active'].toString(),
          ),
          StatusPanel(
            title: 'Sembuh',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: indonesiaData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'Meninggal',
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
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
