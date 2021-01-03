import 'package:coronaampel/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../screens/city_screen.dart';

class CityItem extends StatelessWidget {
  final String name;
  final double incidence;
  final String district;

  CityItem(this.name, this.incidence, this.district);

  final Color txtColor = Colors.black54;

  getBgColor() {
    if (incidence >= 35 && incidence < 50) {
      return Colors.orange[300];
    }
    if (incidence >= 50 && incidence < 200) {
      return Colors.redAccent[700];
    }
    if (incidence >= 200) {
      return Colors.red[900];
    }
    return Colors.green;
  }

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
        margin: EdgeInsets.all(6),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  district,
                  style: TextStyle(color: txtColor),
                ),
                Text(
                  '7 Tage Inzidenz / 100.000',
                  style: TextStyle(color: txtColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: txtColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      incidence.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: txtColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: getBgColor(),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
