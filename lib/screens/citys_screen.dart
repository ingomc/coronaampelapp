import 'package:flutter/material.dart';
import 'package:coronaampel/data/dummy_data.dart';
import '../models/city.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚦 Corona-Ampel 🚦'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: DUMMY_CITYS
            .map((cityData) => CityItem(cityData.name, cityData.incidence))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ),
    );
  }
}
