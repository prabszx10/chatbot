import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class epicentrumeCases extends StatelessWidget {
  final List countryData;

  const epicentrumeCases({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  NetworkImage(countryData[index]['countryInfo']['flag'],),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 20,
                ),
               Flexible(
                 child: Container(
                   height: 30,
//            width: double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.blue[400],
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                           countryData[index]['country'],
                           style:
                           TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                       ),
                       SizedBox(
                         width: 5,
                       ),
                       Text(
                         ' : ' + countryData[index]['cases'].toString(),
                         style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins',color: Colors.white)
                         ,
                       )
                     ],
                   ),
                 ),
               )
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
