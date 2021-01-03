import 'package:coronaampel/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../screens/city_screen.dart';

class CityItem extends StatelessWidget {
  final String name;
  final double incidence;
  final String district;

  CityItem(this.name, this.incidence, this.district);

  Color txtColor = Colors.amber;
  Color bgColor = Colors.black;

  getBgColor() {
    if (incidence >= 35 && incidence < 50) {
      txtColor = Colors.black54;
      bgColor = Colors.orange[300];
      return false;
    }
    if (incidence >= 50 && incidence < 200) {
      txtColor = Colors.black54;
      bgColor = Colors.redAccent[700];
      return false;
    }
    if (incidence >= 200) {
      txtColor = Colors.redAccent[700];
      bgColor = Color.fromRGBO(60, 0, 0, 1);
      return false;
    }
    txtColor = Colors.black54;
    bgColor = Colors.green;
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
    getBgColor();
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
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
