import 'package:coronaampel/models/city.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  var citys = [].obs;

  addCity(City city) {
    citys.add(city);
  }
}
