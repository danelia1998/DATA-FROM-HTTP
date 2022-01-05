import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_http_get/globals.dart' as globals;
import 'package:flutter_http_get/itemdetail.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  String hometown = "david";
  var url = Uri.parse("https://swapi.dev/api/people");

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.https('swapi.dev', 'api/people'),
        //Encode URL
        headers: {"Accept": "application/json"});

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);

      data = convertDataToJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("სთარვორსია ტოო..."),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton(
                    onPressed: () => {
                      globals.link = data[index]['homeworld'],
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      ),
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text(data[index]['name']),
                          Text(data[index]['homeworld']),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
