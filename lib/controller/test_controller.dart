import 'package:coronaampel/models/city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  var citys = [].obs;

  addCity(City city) {
    City cityInList = citys.firstWhere((cityItem) => cityItem.id == city.id,
        orElse: () => null);
    if (cityInList == null) {
      citys.add(city);
    } else {
      citys.remove(cityInList);
      // Get.snackbar(
      //   '',
      //   'Stadt befindet sich bereits auf ihrer List',
      //   icon: Icon(Icons.warning),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }
}
