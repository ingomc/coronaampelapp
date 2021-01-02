import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  final String name;
  final String incidence;

  CityItem(this.name, this.incidence);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(6),
      child: Text(name),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
    );
  }
}
