import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Einstellungen'),
      ),
      body: Container(
          child: Center(
        child: Text('Favo'),
      )),
    );
  }
}
