import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  static const path = '/city';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stadt Name'),
      ),
      body: Center(
        child: Text(
          'Inzidenz: XXXX',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
