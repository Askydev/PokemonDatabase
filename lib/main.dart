import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Image.network(
              'https://raw.githubusercontent.com/mitulgautam/pokemon.json/master/images/001Bulbasaur.png'),
        ),
      ),
    );
  }
}
