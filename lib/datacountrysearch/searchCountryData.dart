import 'package:flutter/material.dart';


class Search extends SearchDelegate{
  final List countryList;
  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.blue,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(icon: Icon(Icons.clear), onPressed: (){
       query='';
     })
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    final suggestionList
         =
           query.isEmpty?
           countryList:
           countryList.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();

   return ListView.builder(
       padding: EdgeInsets.all(10),
       itemCount: suggestionList.length,
       itemBuilder: (context,index){
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
                     suggestionList[index]['country'],
                     style: TextStyle(fontWeight: FontWeight.bold),
                   ),
                   Image.network(
                     suggestionList[index]['countryInfo']['flag'],
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
                             suggestionList[index]['active'].toString(),
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.red),
                       ),
                       Text(
                         'TERKONFIRMASI:' +
                             suggestionList[index]['cases'].toString(),
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                           color: Colors.blue),
                       ),
                       Text(
                         'SEMBUH:' +
                             suggestionList[index]['recovered'].toString(),
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.green),
                       ),
                       Text(
                         'MENINGGAL:' +
                             suggestionList[index]['deaths'].toString(),
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color:  Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                       ),
                     ],
                   ),
                 ))
           ],
         ),
       ),
     ));
   });
  }

}