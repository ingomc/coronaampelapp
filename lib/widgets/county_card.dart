import 'dart:ui';
import 'package:coronaampel/controller/get_single_county_controller.dart';
import 'package:coronaampel/screens/detail/county_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CountyCard extends StatelessWidget {
  final int countyIndex;
  final String rs;
  final String name;
  final String district;
  final double incidence;
  final int newCases;
  final bool isLinked;

  CountyCard(this.countyIndex, this.rs, this.name, this.district,
      this.incidence, this.newCases,
      [this.isLinked = true]);

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

  final GetSingleCountyController getSingleCountyController =
      Get.put(GetSingleCountyController());

  void goToCity() {
    getSingleCountyController.selectedCountyRS.value = rs;
    Get.to(CountyDetailScreen(),
        arguments: countyIndex, transition: Transition.cupertino);
    // Get.to(
    // CityDetailScreen(),
    //   arguments: rs,
    // );
  }

  @override
  Widget build(BuildContext context) {
    getBgColor();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        elevation: 2.0,
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
                            'Neue Fälle: ${newCases != null && newCases > 0 ? newCases : 0}',
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
                          if (incidence >= 200)
                            Icon(
                              Icons.warning_amber_rounded,
                              color: txtColor,
                            ),
                          Container(
                            child: Text(
                              incidence >= 0 ? ' ${incidence.toString()}' : '-',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              isLinked
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: txtColor,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
