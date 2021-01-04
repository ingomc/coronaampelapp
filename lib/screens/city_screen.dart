import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  final String name;
  final String district;
  final double incidence;

  CityScreen(this.name, this.district, this.incidence);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name ($district)'),
      ),
      body: Center(
        child: Text(
          'Inzidenz: ' + incidence.toString(),
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
