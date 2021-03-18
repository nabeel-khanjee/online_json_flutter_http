import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

const primary = Color(0xff4f359b);
const white = Color(0xffffffff);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://jsonplaceholder.typicode.com/todos";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //Encode the urll
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"}
        //to accept only json data
        );

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });

    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Retrieve Json via HTTP Get"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        child: new Text(data[index]['title']),
                        padding: const EdgeInsets.all(20.00),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
