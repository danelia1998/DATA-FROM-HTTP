import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_http_get/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  log(globals.link);
  final response = await http.get(Uri.parse(globals.link));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String name;
  final String diameter;
  final String climate;
  final String gravity;
  final String terrain;
  final String population;

  Album({
    this.name,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.population,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      diameter: json['diameter'],
      climate: json['climate'],
      gravity: json['gravity'],
      terrain: json['terrain'],
      population: json['population'],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chosen person is from : ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chosen person is from :'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text("The Name is : " + snapshot.data.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child:
                          Text("The diameter is : " + snapshot.data.diameter),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text("The climate is : " + snapshot.data.climate),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text("The gravity is : " + snapshot.data.gravity),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text("The terrain is : " + snapshot.data.terrain),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                          "The population is : " + snapshot.data.population),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
