import 'package:flutter/material.dart';

class City {
  final String id;
  final String county;
  final String district;
  final String name;
  final String bundesland;
  final double incidence;

  const City({
    @required this.id,
    @required this.county,
    @required this.district,
    @required this.name,
    @required this.bundesland,
    this.incidence = 0,
  });
}
