import 'package:flutter/material.dart';

// ignore: camel_case_types
class updateHarian extends StatelessWidget {
  final Map updateData;

  const updateHarian({Key key, this.updateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1),
        children: <Widget>[
          StatusPanel(
            title: 'POSITIF',
            panelColor: Colors.red[100],
            textColor: Colors.red[900],
            count: updateData['update']['penambahan']['jumlah_positif'].toString(),
          ),
          StatusPanel(
            title: 'SEMBUH',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: updateData['update']['penambahan']['jumlah_sembuh'].toString(),
          ),
          StatusPanel(
            title: 'MENINGGAL',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count:updateData['update']['penambahan']['jumlah_meninggal'].toString(),
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
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
