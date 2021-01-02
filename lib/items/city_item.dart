import 'package:coronaampel/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../screens/city_screen.dart';

class CityItem extends StatelessWidget {
  final String name;
  final String incidence;
  final String district;

  CityItem(this.name, this.incidence, this.district);

  void selectCity(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CityScreen(name, incidence);
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(district),
                Text('7 Tage Inzidenz / 100.000'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  incidence,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
