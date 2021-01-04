import 'package:flutter/material.dart';
import 'package:coronaampel/data/dummy_data.dart';
import '../models/city.dart';
import '../items/city_item.dart';

class CitysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 100),
      children: DUMMY_CITYS
          .map((cityData) => CityItem(
                cityData.name,
                cityData.district,
                cityData.incidence,
              ))
          .toList(),
    );
  }
}
