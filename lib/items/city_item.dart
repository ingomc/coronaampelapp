import 'package:coronaampel/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../screens/city_screen.dart';

class CityItem extends StatelessWidget {
  final String name;
  final String incidence;

  CityItem(this.name, this.incidence);

  void selectCity(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CityScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCity(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(4),
        padding: const EdgeInsets.all(15),
        child: Text(name),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
