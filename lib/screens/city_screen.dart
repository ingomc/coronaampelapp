import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  final String name;
  final String incidence;

  CityScreen(this.name, this.incidence);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('inzidenz: ' + incidence),
      ),
    );
  }
}
