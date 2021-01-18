import 'package:flutter/material.dart';

class CountyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countyIndex = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('STADTNAME'),
      ),
      body: Center(
        child: Text('Index: ${countyIndex.toString()}'),
      ),
    );
  }
}
