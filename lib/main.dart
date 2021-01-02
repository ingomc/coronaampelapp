import 'package:flutter/material.dart';
import 'package:coronaampel/screens/citys_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona-Ampel',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: CitysScreen(),
    );
  }
}
