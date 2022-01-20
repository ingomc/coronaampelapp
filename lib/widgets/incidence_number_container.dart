// @dart=2.9
import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IncidenceNumberContainer extends StatelessWidget {
  final double incidence;

  IncidenceNumberContainer(this.incidence);

  Color txtColor = Colors.white;
  Color bgColor = Colors.white12;

  getBgColor() {
    if (incidence < 0) {
      txtColor = Colors.white38;
      bgColor = Colors.grey[800];
      return false;
    }
    if (incidence >= 35 && incidence < 50) {
      txtColor = Colors.black54;
      bgColor = Colors.orange[300];
      return false;
    }
    if (incidence >= 50 && incidence < 100) {
      txtColor = Colors.black54;
      bgColor = Colors.redAccent[700];
      return false;
    }
    if (incidence >= 100) {
      txtColor = Colors.redAccent[700];
      bgColor = Color.fromRGBO(60, 0, 0, 1);
      return false;
    }
    txtColor = Colors.black54;
    bgColor = Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    getBgColor();
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${incidence.toStringAsFixed(1)}',
          style: TextStyle(
            color: txtColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}
