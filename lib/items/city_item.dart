import 'package:coronaampel/screens/city_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityItem extends StatelessWidget {
  final String county;
  final String name;
  final String district;
  final double incidence;

  CityItem(
    this.county,
    this.name,
    this.district,
    this.incidence,
  );

  Color txtColor = Colors.amber;
  Color bgColor = Colors.black;

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

  void goToCity() {
    Get.to(
      CityDetailScreen(),
      arguments: county,
    );
  }

  @override
  Widget build(BuildContext context) {
    getBgColor();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () => goToCity(),
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(6),
                  padding: const EdgeInsets.all(8),
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
                            'Inzidenz',
                            style: TextStyle(color: txtColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 4,
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
                                incidence >= 0 ? incidence.toString() : '-',
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
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: txtColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
