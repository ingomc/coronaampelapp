import 'package:flutter/material.dart';

class City {
  final String id;
  final String district;
  final String name;
  final double incidence;

  const City({
    @required this.id,
    @required this.district,
    @required this.name,
    this.incidence = 0,
  });
}
