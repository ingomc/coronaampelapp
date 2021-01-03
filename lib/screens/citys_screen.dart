import 'package:flutter/material.dart';
import 'package:coronaampel/data/dummy_data.dart';
import '../models/city.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🚦 Corona-Ampel 🚦'),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: DUMMY_CITYS
            .map((cityData) =>
                CityItem(cityData.name, cityData.incidence, cityData.district))
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
