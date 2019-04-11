import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'pokemon_name.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _list(BuildContext context, String url, String data) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150.0,
            height: 150.0,
            child: Image.network(url),
          ),
          Container(
            child: Text(
              data,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: RandomColor().randomColor()),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Pokemon>> _getData() async {
    String url =
        "https://raw.githubusercontent.com/mitulgautam/pokemon.json/master/pokedex.json";
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
    List<Pokemon> pokemon = [];
    for (var i in jsonData) {
      Pokemon p = Pokemon(i.toString(), i['name']['english']);
      pokemon.add(p);
    }
    return pokemon;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return _list(
                      context, url(i, snapshot), snapshot.data[i].name);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

String url(int i, AsyncSnapshot snapshot) {
  int a = i + 1;
  String url =
      "https://raw.githubusercontent.com/mitulgautam/pokemon.json/master/thumbnails/";
  if (a < 10) {
    return url + "00" + a.toString() + snapshot.data[i].name + ".png";
  } else if (a < 100) {
    return url + "0" + a.toString() + snapshot.data[i].name + ".png";
  } else
    return url + a.toString() + snapshot.data[i].name + ".png";
}
