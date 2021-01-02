import 'package:flutter/material.dart';

class City {
  final String id;
  final String district;
  final String name;
  final String incidence;

  const City(
      {@required this.id, @required this.district, this.name, this.incidence});
}
