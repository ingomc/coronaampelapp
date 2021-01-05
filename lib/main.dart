import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';

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
        accentColor: Colors.teal[300],
      ),
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}
