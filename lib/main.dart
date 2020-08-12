import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot Covid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//        home: MyHomePage(title: 'MyHomepage Title')
      home: SplashScreen(),
    );
  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "https://supercodebot.herokuapp.com"; // replace with server address
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Chatbot"),
      ),

      body: Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(   
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)) ),
                padding: EdgeInsets.all(10),
                child: Text("Today"),
              ),
            ),

            Flexible(
              
              child:     AnimatedList(
                 padding: EdgeInsets.only(top:30, bottom: 15),
              // key to call remove and insert from anywhere
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return _buildItem(_data[index], animation, index);
              }),
            ),

            Divider(
              height: 0,
              color: Colors.blue,
            ),

            Container(
              decoration: BoxDecoration(
          color: Colors.white
        ),
              child: ListTile(
                
                title: Container(
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        hintText: "Type a Massage",
                        hintStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                            maxLines: 1,
                            controller: _queryController,
              textInputAction: TextInputAction.send,
              onSubmitted: (msg) {
                this._getResponse();
              },
                  ),
                  
                ),
                trailing: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 40,
                  color: Colors.blue,
                  // splashColor: Colors.purple,
                  onPressed: () {
                    this._getResponse();
                  },
                ),
              ),
            )

          ],
        ),
      ),
     
    );
  }

  http.Client _getClient() {
    return http.Client();
  }

  void _getResponse() {
    if (_queryController.text.length > 0) {
      this._insertSingleItem(_queryController.text);
      var client = _getClient(); // get http client
      try {
        client.post(
          BOT_URL,
          body: {"query": _queryController.text},
        )..then((response) {
            Map<String, dynamic> data =
                jsonDecode(response.body); // decode json data
            _insertSingleItem(data['response'] + "<bot>"); // add response
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close(); // close client
        _queryController.clear();
      }
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              alignment: mine ? Alignment.topLeft : Alignment.topRight,

              child: Bubble(
                child: Text(item.replaceAll("<bot>", "")),
                color: mine ? Colors.blue : Colors.blue[100],
                padding: BubbleEdges.all(20),
              
              )),
        ));
  }

}
